import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ReadingSaveButton extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ReadingSaveButton({
    super.key,
    required this.isSaved,
    required this.onSave,
  });

  final bool isSaved;

  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isSaved ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSaved ? const Color(0xFF10B981) : Colors.white,
            foregroundColor: isSaved ? Colors.white : Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isSaved ? Icons.check_circle : Icons.bookmark, size: 20.0),
              const SizedBox(width: 10.0),
              Text(
                isSaved ? 'Saved to Journal' : 'Save to Journal',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
