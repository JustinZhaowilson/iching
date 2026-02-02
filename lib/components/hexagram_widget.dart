import 'package:flutter/material.dart';
import 'package:iching/hexagram_line.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/line_type.dart';

@NowaGenerated()
class HexagramWidget extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramWidget({super.key, required this.lines});

  final List<HexagramLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2630),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = lines.length - 1; i >= 0; i--)
            Padding(
              padding: EdgeInsets.only(bottom: i > 0 ? 8 : 0),
              child: _buildLine(lines[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildLine(HexagramLine line) {
    final lineColor = line.isChanging && line.changingColor != null
        ? line.changingColor
        : const Color(0xffd1d5db);
    if (line.type == LineType.solid) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          if (line.isChanging) ...[
            const SizedBox(width: 8.0),
            Text(
              '×',
              style: TextStyle(
                color: lineColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
        ],
      );
    }
  }
}
