import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'mini_hex_line.dart';

@NowaGenerated()
class MiniHexagramWidget extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MiniHexagramWidget({super.key, required this.lineValues});

  final List<int> lineValues;

  @override
  Widget build(BuildContext context) {
    if (lineValues.length != 6) return const SizedBox(width: 40);
    return Container(
      width: 40,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1419),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 5; i >= 0; i--) MiniHexLine(value: lineValues[i]),
        ],
      ),
    );
  }
}
