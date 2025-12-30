import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../../shared/domain/entities/ai/context_models.dart';
import 'dart:convert';

class AITestScreen extends ConsumerStatefulWidget {
  const AITestScreen({super.key});

  @override
  ConsumerState<AITestScreen> createState() => _AITestScreenState();
}

class _AITestScreenState extends ConsumerState<AITestScreen> {
  final _formKey = GlobalKey<FormState>();
  String _output = '';
  bool _isLoading = false;

  // Form Fields
  int _age = 30;
  String _gender = 'male';
  String _experienceLevel = 'intermediate';
  double _weeklyMileage = 20.0;
  String _goalType = 'distance'; // distance, time, consistency
  String _goalTarget = 'Marathon';
  int _goalWeeks = 16;
  final List<String> _availableDays = ['mon', 'wed', 'fri', 'sat'];

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
        trainingHistory: [],
        trainingPhilosophy: 'Standard Periodization',
      );

      final result = await service.generatePlan(
        context: context,
        systemPrompt: 'You are an expert running coach.',
        taskPrompt:
            'Generate a $_goalWeeks week training plan for a $_experienceLevel runner training for $_goalTarget.',
        responseSchema: _getSchema(),
      );

      setState(() {
        _output =
            'Tokens: ${result.tokensUsed}\n\n${const JsonEncoder.withIndent('  ').convert((result.data as dynamic).toJson())}';
      });
    } catch (e, st) {
      setState(() {
        _output = 'Error: $e\n$st';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Map<String, dynamic> _getSchema() {
    return {
      "type": "object",
      "properties": {
        "mesocycles": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "id": {"type": "string"},
              "name": {"type": "string"},
              "startDate": {"type": "string"},
              "endDate": {"type": "string"},
              "emphasis": {"type": "string"}
            }
          }
        },
        "microcycles": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "id": {"type": "string"},
              "weekNumber": {"type": "integer"},
              "startDate": {"type": "string"},
              "endDate": {"type": "string"},
              "emphasis": {"type": "string"}
            }
          }
        },
        "workouts": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "id": {"type": "string"},
              "userId": {"type": "integer"},
              "goalId": {"type": "integer"},
              "scheduledDate": {"type": "string"},
              "type": {"type": "string"},
              "name": {"type": "string"},
              "plannedDuration": {"type": "integer"}, // seconds
              "plannedDistance": {"type": "number"}, // km
              "status": {"type": "string"}
            }
          }
        },
        "rationale": {
          "type": "object",
          "properties": {
            "overallApproach": {"type": "string"},
            "intensityDistribution": {"type": "string"},
            "keyWorkouts": {"type": "string"},
            "recoveryStrategy": {"type": "string"}
          }
        }
      }
    };
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
                      value: _experienceLevel,
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
                      value: _goalType,
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
          // Right Side: Output
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Model Output',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black12,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: SelectableText(_output,
                          style: const TextStyle(fontFamily: 'monospace')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
