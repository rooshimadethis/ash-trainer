import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../../../infrastructure/services/ai_service.dart';
import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/constants/ai_schemas.dart';
import '../../../../core/constants/prompts.dart';
import 'dart:convert';
import '../../../../data/providers/repository_providers.dart';
import '../../../../features/shared/domain/entities/goal.dart';
import '../../../training/application/usecases/build_plan_generation_context.dart';

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
  String _goalType = 'distance'; // distance, time, consistency
  String _goalTarget = 'Marathon';
  int _goalWeeks = 16;
  bool _isFirstTime = false;
  int? _currentBestTime; // in seconds
  String? _eventName;

  List<String> _availableDays = ['mon', 'wed', 'fri', 'sat'];
  String _trainingPhilosophy = 'Standard Periodization';
  double _confidence = 0.8;

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

      final builder = BuildPlanGenerationContext(
        ref.read(userRepositoryProvider),
        ref.read(goalRepositoryProvider),
        ref.read(workoutRepositoryProvider),
      );

      final contextData = await builder.execute(goalId: selectedGoal.id);

      setState(() {
        // Populate Form - User fields
        _age = contextData.user.age;
        _gender = contextData.user.gender;
        _trainingFrequency = contextData.user.weeklyTrainingFrequency ?? 4;
        _weeklyVolume = contextData.user.weeklyVolume ?? 20.0;
        _availableDays = contextData.user.availableDays;

        // Populate Form - Goal fields
        _goalType = contextData.goal.type;
        _goalTarget = contextData.goal.target;
        _confidence = contextData.goal.confidence;
        _isFirstTime = contextData.goal.isFirstTime ?? false;
        _currentBestTime = contextData.goal.currentBestTime;
        _eventName = contextData.goal.eventName;
        _runningPriority = contextData.goal.runningPriority ?? 'high';
        _strengthPriority = contextData.goal.strengthPriority ?? 'medium';
        _mobilityPriority = contextData.goal.mobilityPriority ?? 'low';
        _trainingPhilosophy =
            contextData.trainingPhilosophy; // Load real philosophy

        // Calculate approx weeks from deadline
        _goalWeeks = (contextData.goal.daysUntilGoal ?? 112) ~/ 7;

        _output = 'Loaded context for Goal: ${selectedGoal.id}';
      });
    } catch (e) {
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
      final daysUntilGoal = deadline.difference(DateTime.now()).inDays;

      final context = PlanGenerationContext(
        user: UserContext(
          age: _age,
          gender: _gender,
          availableDays: _availableDays,
          timeConstraints: {},
          injuryHistory: [],
          // Current training metrics
          weeklyTrainingFrequency: _trainingFrequency,
          weeklyVolume: _weeklyVolume,
        ),
        goal: GoalContext(
          type: _goalType,
          target: _goalTarget,
          deadline: deadline,
          confidence: _confidence,
          specialInstructions: [],
          isFirstTime: _isFirstTime,
          // Timeline calculations
          daysUntilGoal: daysUntilGoal,
          // Goal-specific parameters
          currentBestTime: _currentBestTime,
          eventName: _eventName,
          // Pillar priorities
          runningPriority: _runningPriority,
          strengthPriority: _strengthPriority,
          mobilityPriority: _mobilityPriority,
        ),
        trainingHistory: [], // TODO: We could populate this from real data too if we updated the context builder to expose it more easily, or keep it empty for "Manual" test
        trainingPhilosophy: _trainingPhilosophy,
      );

      const systemPrompt = AIPrompts.ashPersona;
      const taskPrompt = AIPrompts.generatePlanTask;

      final contextJson =
          const JsonEncoder.withIndent('  ').convert(context.toJson());

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
        context: context,
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

      debugPrint('--- AI INPUT JSON ---');
      debugPrint(_inputJson);
      debugPrint('--- AI RAW RESPONSE ---');
      debugPrint(_rawResponse);
      debugPrint('--- AI PARSED OUTPUT ---');
      debugPrint(_output);
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
      debugPrint('--- AI ERROR ---');
      debugPrint(e.toString());
      debugPrint(st.toString());
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
                            value: 'maintenance', child: Text('Maintenance')),
                      ],
                      onChanged: (v) => setState(() => _goalType = v!),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Target Event'),
                      initialValue: 'Marathon',
                      onSaved: (v) => _goalTarget = v!,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Duration (Weeks)'),
                      initialValue: '16',
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
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Event Name (optional)'),
                      initialValue: _eventName ?? '',
                      onSaved: (v) => _eventName = v!.isEmpty ? null : v,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Training Philosophy'),
                      initialValue: _trainingPhilosophy,
                      maxLines: 2,
                      onSaved: (v) => _trainingPhilosophy = v!,
                    ),
                    const SizedBox(height: 16),
                    Text('Confidence: $_confidence'),
                    Slider(
                      value: _confidence,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      label: _confidence.toString(),
                      onChanged: (v) => setState(() => _confidence = v),
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
}
