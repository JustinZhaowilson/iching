import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class MiniHexLine extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MiniHexLine({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    final bool isSolid = value == 7 || value == 9;
    final bool isChanging = value == 6 || value == 9;
    final Color color = isChanging
        ? const Color(0xFFFF9500)
        : const Color(0xFF3478F6);
    if (isSolid) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4.0),
        height: 3.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(1.0),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4.0),
        height: 3.0,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1.0),
                ),
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
