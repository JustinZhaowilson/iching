import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ReadingQuestionInput extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ReadingQuestionInput({
    super.key,
    required this.controller,
    required this.isSaved,
  });

  final TextEditingController controller;

  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1C2630),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'What was your question? (Optional)',
            hintStyle: TextStyle(color: Color(0xFF8E9BAE)),
            border: InputBorder.none,
            icon: Icon(Icons.help_outline, color: Color(0xFF3478F6)),
          ),
          maxLines: null,
          enabled: !isSaved,
        ),
      ),
    );
  }
}
