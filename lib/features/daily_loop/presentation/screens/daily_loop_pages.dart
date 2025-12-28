import 'package:flutter/material.dart';

class ChatAdjustmentScreen extends StatefulWidget {
  const ChatAdjustmentScreen({super.key});

  @override
  State<ChatAdjustmentScreen> createState() => _ChatAdjustmentScreenState();
}

class _ChatAdjustmentScreenState extends State<ChatAdjustmentScreen> {
  final List<String> _messages = [
    "Ash: I hear you. Can you tell me more? Are you physically exhausted or mentally drained?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Ash")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(_messages[index]),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              children: [
                ActionChip(
                  label: const Text("Physically exhausted"),
                  onPressed: () {
                    setState(() {
                      _messages.add("User: Physically exhausted");
                      _messages.add(
                        "Ash: Got it. Let's switch to a recovery walk or rest day.",
                      );
                    });
                  },
                ),
                ActionChip(
                  label: const Text("Mentally drained"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostWorkoutLogScreen extends StatefulWidget {
  const PostWorkoutLogScreen({super.key});

  @override
  State<PostWorkoutLogScreen> createState() => _PostWorkoutLogScreenState();
}

class _PostWorkoutLogScreenState extends State<PostWorkoutLogScreen> {
  double _rpe = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log Workout")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "How did that feel?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text("RPE: ${_rpe.round()} - Easy (Conversational)"),
            Slider(
              value: _rpe,
              min: 1,
              max: 10,
              divisions: 9,
              label: _rpe.round().toString(),
              onChanged: (val) {
                setState(() {
                  _rpe = val;
                });
              },
            ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                labelText: "Notes",
                hintText: "Any pain or additional thoughts?",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Nice work!"),
                    content: const Text(
                      "That RPE tells me you're recovering well. See you tomorrow!",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Close screen
                        },
                        child: const Text("Done"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Save Log"),
            ),
          ],
        ),
      ),
    );
  }
}
