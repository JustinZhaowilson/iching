import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramNotesSection extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramNotesSection({
    super.key,
    required this.controller,
    required this.isSaving,
    required this.onSave,
    required this.onDelete,
    required this.themeColor,
  });

  final TextEditingController controller;

  final bool isSaving;

  final void Function() onSave;

  final void Function() onDelete;

  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Personal Notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (controller.text.trim().isNotEmpty)
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFF8E9BAE),
                ),
                onPressed: onDelete,
              ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1C2630),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                maxLines: 5,
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
                decoration: const InputDecoration(
                  hintText:
                      'Add your own insights and reflections for this hexagram...',
                  hintStyle: TextStyle(color: Color(0xFF8E9BAE)),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSaving ? null : onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: isSaving
                      ? const SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save Note',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
