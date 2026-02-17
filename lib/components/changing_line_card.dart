import 'package:flutter/material.dart';
import 'package:iching/models/hexagram_meta.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ChangingLineCard extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ChangingLineCard({super.key, required this.index, required this.meta});

  final int index;

  final HexagramMeta meta;

  @override
  Widget build(BuildContext context) {
    if (index < 0 || index >= meta.lines.length) {
      return const SizedBox.shrink();
    }
    final lineData = meta.lines[index];
    final lineNum = index + 1;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2418),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFF4A3A28), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF9500),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$lineNum',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                'Line $lineNum',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            '"${lineData.changingText}"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            lineData.baseText,
            style: const TextStyle(
              color: Color(0xFF8E9BAE),
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
