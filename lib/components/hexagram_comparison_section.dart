import 'package:flutter/material.dart';
import 'package:iching/models/hexagram.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/hexagram_line.dart';
import 'package:iching/line_type.dart';
import 'package:iching/components/hexagram_widget.dart';

@NowaGenerated()
class HexagramComparisonSection extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramComparisonSection({
    super.key,
    required this.primary,
    required this.future,
  });

  final Hexagram primary;

  final Hexagram future;

  List<HexagramLine> _mapLines(Hexagram h) {
    return h.lines
        .map(
          (l) => HexagramLine(
            type: l.isSolid ? LineType.solid : LineType.broken,
            isChanging: l.isChanging,
            changingColor: l.isChanging ? const Color(0xFFFF9500) : null,
          ),
        )
        .toList();
  }

  List<HexagramLine> _mapFutureLines(Hexagram h) {
    return h.lines
        .map(
          (l) => HexagramLine(
            type: l.isSolid ? LineType.solid : LineType.broken,
            isChanging: false,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'PRESENT',
                  style: TextStyle(
                    color: Color(0xFF8E9BAE),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16.0),
                HexagramWidget(lines: _mapLines(primary)),
                const SizedBox(height: 12.0),
                Text(
                  'Hex ${primary.number}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          const Icon(Icons.arrow_forward, color: Color(0xFF3A4556), size: 28.0),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'FUTURE',
                  style: TextStyle(
                    color: Color(0xFF8E9BAE),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16.0),
                HexagramWidget(lines: _mapFutureLines(future)),
                const SizedBox(height: 12.0),
                Text(
                  'Hex ${future.number}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
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
