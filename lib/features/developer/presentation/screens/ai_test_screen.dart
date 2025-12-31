import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../../../infrastructure/services/ai_service.dart';
import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/constants/ai_schemas.dart';
import '../../../../core/constants/prompts.dart';
import 'dart:convert';
import '../../../../data/providers/repository_providers.dart';
import '../../../shared/domain/entities/goal.dart';
import '../../../training/application/usecases/build_planning_context.dart';
import '../../../training/application/usecases/build_plan_philosophy.dart';
import '../../../../core/utils/logger.dart';

class AITestScreen extends ConsumerStatefulWidget {
  const AITestScreen({super.key});

  @override
  ConsumerState<AITestScreen> createState() => _AITestScreenState();
}

class _AITestScreenState extends ConsumerState<AITestScreen> {
  final _formKey = GlobalKey<FormState>();
  String _output = '';
  String _inputJson = '';
  String _rawResponse = '';
  bool _isLoading = false;

  // Form Fields - User
  int _age = 30;
  String _gender = 'male';
  int _trainingFrequency = 4;
  double _weeklyVolume = 20.0;
  String _runningPriority = 'high';
  String _strengthPriority = 'medium';
  String _mobilityPriority = 'low';

  // Form Fields - Goal
  String _goalType = 'distance'; // distance, time, maintenance, event
  double _selectedDistance = 42.2;
  int _goalWeeks = 16;
  bool _isFirstTime = false;
  int? _targetTime; // in seconds
  int? _currentBestTime; // in seconds
  String? _eventName;

  List<String> _availableDays = ['mon', 'wed', 'fri', 'sat'];
  String _trainingPhilosophy = 'Standard Periodization';

  Future<void> _loadFromRealData() async {
    try {
      final goalRepo = ref.read(goalRepositoryProvider);
      final goals = await goalRepo.getGoals();

      if (goals.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No active goals found in DB')));
        return;
      }

      if (!mounted) return;
      final selectedGoal = await showDialog<Goal>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: const Text('Select a Goal'),
          children: goals
              .map((g) => SimpleDialogOption(
                    onPressed: () => Navigator.pop(ctx, g),
                    child: Text('${g.type.name} - ${g.id}'),
                  ))
              .toList(),
        ),
      );

      if (selectedGoal == null) return;

      setState(() => _output = 'Loading context...');

      final builder = BuildPlanningContext(
        ref.read(userRepositoryProvider),
        ref.read(goalRepositoryProvider),
        ref.read(workoutRepositoryProvider),
      );

      final contextData = await builder.execute(
        goalId: selectedGoal.id,
        mode: PlanningMode.initial,
      );

      setState(() {
        // Populate Form - User fields
        _age = contextData.user.age ?? 30;
        _gender = contextData.user.gender ?? 'unknown';
        _availableDays = contextData.user.availableDays;
        // Approximation as these are no longer in context directly
        _trainingFrequency = contextData.user.availableDays.length;

        // Populate Form - Goal fields
        _goalType = contextData.goal.type;
        _selectedDistance = double.tryParse(
                contextData.goal.target.replaceAll(RegExp(r'[^0-9.]'), '')) ??
            42.2;
        _isFirstTime = contextData.goal.isFirstTime ?? false;
        _runningPriority = contextData.goal.priorities['running'] ?? 'high';
        _strengthPriority = contextData.goal.priorities['strength'] ?? 'medium';
        _mobilityPriority = contextData.goal.priorities['mobility'] ?? 'low';
        _weeklyVolume = contextData.goal.initialWeeklyVolume ?? 20.0;

        _trainingPhilosophy = const JsonEncoder.withIndent('  ')
            .convert(contextData.philosophy.toJson());

        // Calculate approx weeks based on context deadline
        final days =
            contextData.goal.deadline.difference(DateTime.now()).inDays;
        _goalWeeks = days ~/ 7;

        _output = 'Loaded context for Goal: ${selectedGoal.id}';
      });
    } catch (e, stack) {
      AppLogger.error('Error loading data in AI Test Screen', e, stack);
      setState(() => _output = 'Error loading data: $e');
    }
  }

  Future<void> _generatePlan() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
      _output = 'Generating plan...';
    });

    try {
      final service = ref.read(aiServiceProvider);

      // Calculate timeline
      final deadline = DateTime.now().add(Duration(days: _goalWeeks * 7));

      final context = PlanGenerationContext(
        config: PlanningConfig(
          mode: PlanningMode.initial,
          startDate: DateTime.now(),
          instruction: 'Create a plan from scratch',
        ),
        user: UserContext(
          age: _age,
          gender: _gender,
          availableDays: _availableDays,
          constraints: null,
        ),
        goal: GoalContext(
          type: _goalType,
          target: _targetTime != null
              ? 'Run ${_selectedDistance}km in $_targetTime seconds'
              : (_goalType == 'event' && _eventName != null
                  ? 'Train for $_eventName'
                  : 'Run ${_selectedDistance}km'),
          deadline: deadline,
          currentFitness: null, // Test screen assumption
          initialWeeklyVolume: _weeklyVolume,
          isFirstTime: _isFirstTime,
          priorities: {
            'running': _runningPriority,
            'strength': _strengthPriority,
            'mobility': _mobilityPriority,
          },
        ),
        trainingHistory: [],
        philosophy: buildPlanPhilosophy(
          goal: Goal(
            id: 'test-goal',
            userId: 'test-user',
            type: _getGoalType(_goalType),
            name: 'Test Goal',
            targetDistance: _selectedDistance,
            targetDate: deadline,
            targetTime: _targetTime,
            initialTrainingFrequency: _trainingFrequency,
            initialWeeklyVolume: _weeklyVolume,
            runningPriority: _runningPriority,
            strengthPriority: _strengthPriority,
            mobilityPriority: _mobilityPriority,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          weeklyVolume: _weeklyVolume,
        ),
      );

      const systemPrompt = AIPrompts.ashPersona;
      const taskPrompt = AIPrompts.generatePlanTask;

      final contextJson = const JsonEncoder.withIndent('  ')
          .convert(PlanGenerationContext.activeToJson(context));

      setState(() {
        _inputJson = '''
=== SYSTEM PROMPT ===
$systemPrompt

=== TASK PROMPT ===
$taskPrompt

=== CONTEXT JSON ===
$contextJson
''';
      });

      final result = await service.generatePlan(
        context:
            context, // Service handles toJson internally, but we simulate it above
        systemPrompt: systemPrompt,
        taskPrompt: taskPrompt,
        responseSchema: AISchemas.trainingPlan,
      );

      final prettyOutput =
          'Tokens: ${result.tokensUsed}\n\n${const JsonEncoder.withIndent('  ').convert((result.data as dynamic).toJson())}';

      setState(() {
        _rawResponse = result.text ?? 'No raw text';
        _output = prettyOutput;
      });

      AppLogger.info('--- AI INPUT JSON ---');
      AppLogger.info(_inputJson);
      AppLogger.info('--- AI RAW RESPONSE ---');
      AppLogger.info(_rawResponse);
      AppLogger.info('--- AI PARSED OUTPUT ---');
      AppLogger.info(_output);
    } catch (e, st) {
      if (e is AIProcessingException) {
        setState(() {
          _rawResponse = e.rawResponse ?? 'No raw text available';
          _output = 'Parsing Error: ${e.message}';
        });
        debugPrint('--- AI RAW RESPONSE (From Exception) ---');
        debugPrint(_rawResponse);
      } else {
        setState(() {
          _output = 'Error: $e\n$st';
          _rawResponse = '';
        });
      }
      AppLogger.error('AI Test Screen Analysis Error', e, st);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Plan Generator')),
      body: Row(
        children: [
          // Left Side: Form
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('User Profile',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_download),
                      label: const Text('Load from DB'),
                      onPressed: _isLoading ? null : _loadFromRealData,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Age'),
                      initialValue: '30',
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _age = int.parse(v!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Gender'),
                      initialValue: 'male',
                      onSaved: (v) => _gender = v!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Training Frequency (days/week)'),
                      initialValue: '4',
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _trainingFrequency = int.parse(v!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Weekly Volume (km)'),
                      initialValue: '20',
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _weeklyVolume = double.parse(v!),
                    ),
                    const SizedBox(height: 16),
                    const Text('Available Days',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        'mon',
                        'tue',
                        'wed',
                        'thu',
                        'fri',
                        'sat',
                        'sun'
                      ].map((day) {
                        final isSelected = _availableDays.contains(day);
                        return FilterChip(
                          label: Text(day.toUpperCase()),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _availableDays.add(day);
                              } else {
                                _availableDays.remove(day);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text('Pillar Priorities',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      initialValue: _runningPriority,
                      decoration: const InputDecoration(labelText: 'Running'),
                      items: const [
                        DropdownMenuItem(value: 'high', child: Text('High')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Medium')),
                        DropdownMenuItem(value: 'low', child: Text('Low')),
                      ],
                      onChanged: (v) => setState(() => _runningPriority = v!),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: _strengthPriority,
                      decoration: const InputDecoration(labelText: 'Strength'),
                      items: const [
                        DropdownMenuItem(value: 'high', child: Text('High')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Medium')),
                        DropdownMenuItem(value: 'low', child: Text('Low')),
                      ],
                      onChanged: (v) => setState(() => _strengthPriority = v!),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: _mobilityPriority,
                      decoration: const InputDecoration(labelText: 'Mobility'),
                      items: const [
                        DropdownMenuItem(value: 'high', child: Text('High')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Medium')),
                        DropdownMenuItem(value: 'low', child: Text('Low')),
                      ],
                      onChanged: (v) => setState(() => _mobilityPriority = v!),
                    ),
                    const SizedBox(height: 24),
                    const Text('Goal',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _goalType,
                      decoration: const InputDecoration(labelText: 'Goal Type'),
                      items: const [
                        DropdownMenuItem(
                            value: 'distance', child: Text('Distance')),
                        DropdownMenuItem(
                            value: 'time', child: Text('Time Performance')),
                        DropdownMenuItem(
                            value: 'event', child: Text('Event (Race)')),
                        DropdownMenuItem(
                            value: 'maintenance', child: Text('Maintenance')),
                      ],
                      onChanged: (v) => setState(() => _goalType = v!),
                    ),
                    const SizedBox(height: 16),
                    if (_goalType == 'event')
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Event Name'),
                        initialValue: _eventName ?? '',
                        onChanged: (v) => _eventName = v,
                        validator: (v) =>
                            (_goalType == 'event' && (v == null || v.isEmpty))
                                ? 'Required for events'
                                : null,
                      ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<double>(
                      initialValue: _selectedDistance,
                      decoration: const InputDecoration(labelText: 'Distance'),
                      items: const [
                        DropdownMenuItem(value: 5.0, child: Text('5K')),
                        DropdownMenuItem(value: 10.0, child: Text('10K')),
                        DropdownMenuItem(
                            value: 21.1, child: Text('Half Marathon')),
                        DropdownMenuItem(value: 42.2, child: Text('Marathon')),
                        DropdownMenuItem(value: -1.0, child: Text('Custom')),
                      ],
                      onChanged: (v) => setState(() => _selectedDistance = v!),
                    ),
                    if (_selectedDistance == -1.0)
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Custom Distance (km)'),
                        keyboardType: TextInputType.number,
                        onChanged: (v) =>
                            _selectedDistance = double.tryParse(v) ?? 0.0,
                      ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Target Time (seconds, optional)'),
                      initialValue: _targetTime?.toString() ?? '',
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _targetTime =
                          (v != null && v.isNotEmpty) ? int.parse(v) : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Duration (Weeks)'),
                      initialValue: _goalWeeks.toString(),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _goalWeeks = int.parse(v!),
                    ),
                    CheckboxListTile(
                      title: const Text('First time attempting this distance?'),
                      value: _isFirstTime,
                      onChanged: (v) =>
                          setState(() => _isFirstTime = v ?? false),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Current Best Time (seconds, optional)'),
                      initialValue: _currentBestTime?.toString() ?? '',
                      keyboardType: TextInputType.number,
                      onSaved: (v) =>
                          _currentBestTime = v!.isEmpty ? null : int.parse(v),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Training Philosophy (JSON Override)'),
                      initialValue: _trainingPhilosophy,
                      maxLines: 4,
                      onSaved: (v) => _trainingPhilosophy = v!,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _generatePlan,
                        child: Text(_isLoading ? 'Generating...' : 'GENERATE'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Right Side: Tabs
          Expanded(
            flex: 2,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Input'),
                      Tab(text: 'Raw Response'),
                      Tab(text: 'Parsed Output'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Input Tab
                        Container(
                          color: Colors.black12,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: SelectableText(
                              _inputJson.isEmpty
                                  ? 'No request generated yet'
                                  : _inputJson,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                        ),
                        // Raw Response Tab
                        Container(
                          color: Colors.black12,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: SelectableText(
                              _rawResponse.isEmpty
                                  ? 'No response yet'
                                  : _rawResponse,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                        ),
                        // Output Tab
                        Container(
                          color: Colors.black12,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: SelectableText(
                              _output.isEmpty ? 'No response yet' : _output,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GoalType _getGoalType(String type) {
    switch (type) {
      case 'distance':
        return GoalType.distanceMilestone;
      case 'time':
        return GoalType.timePerformance;
      case 'maintenance':
        return GoalType.maintenance;
      case 'event':
        return GoalType.event;
      default:
        return GoalType.distanceMilestone;
    }
  }
}
