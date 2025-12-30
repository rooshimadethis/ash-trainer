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

  // Form Fields
  int _age = 30;
  String _gender = 'male';
  String _experienceLevel = 'intermediate';
  double _weeklyMileage = 20.0;
  String _goalType = 'distance'; // distance, time, consistency
  String _goalTarget = 'Marathon';
  int _goalWeeks = 16;

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
        // Populate Form
        _age = contextData.user.age;
        _gender = contextData.user.gender;
        _experienceLevel = contextData.user.experienceLevel;
        _weeklyMileage = contextData.user.weeklyMileageBase ?? 20.0;
        _availableDays = contextData.user.availableDays;

        _goalType = contextData.goal.type;
        _goalTarget = contextData.goal.target;
        _confidence = contextData.goal.confidence;
        _trainingPhilosophy =
            contextData.trainingPhilosophy; // Load real philosophy

        // Calculate approx weeks from deadline
        final days =
            contextData.goal.deadline.difference(DateTime.now()).inDays;
        _goalWeeks = (days / 7).round();
        if (_goalWeeks < 1) _goalWeeks = 1;

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

      final context = PlanGenerationContext(
        user: UserContext(
          age: _age,
          gender: _gender,
          experienceLevel: _experienceLevel,
          availableDays: _availableDays,
          timeConstraints: {},
          injuryHistory: [],
          weeklyMileageBase: _weeklyMileage,
        ),
        goal: GoalContext(
          type: _goalType,
          target: _goalTarget,
          deadline: DateTime.now().add(Duration(days: _goalWeeks * 7)),
          confidence: 0.8,
          specialInstructions: [],
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
                    DropdownButtonFormField<String>(
                      initialValue: _experienceLevel,
                      decoration:
                          const InputDecoration(labelText: 'Experience'),
                      items: const [
                        DropdownMenuItem(
                            value: 'beginner', child: Text('Beginner')),
                        DropdownMenuItem(
                            value: 'intermediate', child: Text('Intermediate')),
                        DropdownMenuItem(
                            value: 'advanced', child: Text('Advanced')),
                      ],
                      onChanged: (v) => setState(() => _experienceLevel = v!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Weekly Mileage (km)'),
                      initialValue: '20',
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _weeklyMileage = double.parse(v!),
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
