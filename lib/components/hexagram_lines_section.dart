import 'package:flutter/material.dart';
import 'package:iching/models/hexagram_meta.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/components/hexagram_line_detail_card.dart';

@NowaGenerated()
class HexagramLinesSection extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramLinesSection({
    super.key,
    required this.meta,
    this.changingLinePositions,
    required this.themeColor,
  });

  final HexagramMeta meta;

  final List<int>? changingLinePositions;

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
              'The Lines',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ...meta.lines.reversed.map(
          (line) => HexagramLineDetailCard(
            line: line,
            isChanging: changingLinePositions?.contains(line.position) ?? false,
            themeColor: themeColor,
          ),
        ),
      ],
    );
  }
}
