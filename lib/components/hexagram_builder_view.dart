import 'package:flutter/material.dart';
import 'package:iching/components/stroke_reveal_hex_line.dart';
import 'package:iching/models/coin_toss.dart';
import 'package:iching/models/hexagram.dart';

/// A widget that builds a hexagram line-by-line with animated reveals.
/// 
/// The hexagram is built from bottom to top, with each line revealed
/// using the [StrokeRevealHexLine] animation. Optionally generates
/// lines automatically using the coin toss method.
class HexagramBuilderView extends StatefulWidget {
  /// Called when all 6 lines have been revealed and hexagram is complete.
  final void Function(Hexagram hexagram)? onComplete;
  
  /// Duration for each line's reveal animation.
  final Duration lineRevealDuration;
  
  /// Pause between revealing each line.
  final Duration pauseBetweenLines;
  
  /// If provided, uses these lines instead of generating via coin toss.
  final List<HexLine>? predefinedLines;
  
  /// Color for changing lines.
  final Color changingColor;
  
  /// Color for non-changing lines.
  final Color normalColor;

  const HexagramBuilderView({
    super.key,
    this.onComplete,
    this.lineRevealDuration = const Duration(milliseconds: 700),
    this.pauseBetweenLines = const Duration(milliseconds: 300),
    this.predefinedLines,
    this.changingColor = const Color(0xFFFF9500),
    this.normalColor = const Color(0xFFD1D5DB),
  });

  @override
  State<HexagramBuilderView> createState() => _HexagramBuilderViewState();
}

class _HexagramBuilderViewState extends State<HexagramBuilderView> {
  final CoinTosser _tosser = CoinTosser();
  final List<HexLine> _lines = [];
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _startBuilding();
  }

  Future<void> _startBuilding() async {
    for (int i = 0; i < 6; i++) {
      final HexLine line;
      
      if (widget.predefinedLines != null && i < widget.predefinedLines!.length) {
        line = widget.predefinedLines![i];
      } else {
        final toss = _tosser.toss();
        final type = toss.toLineType();
        line = HexLine(type);
      }

      if (mounted) {
        setState(() {
          _lines.add(line);
        });
      }

      await Future.delayed(
        widget.lineRevealDuration + widget.pauseBetweenLines,
      );
    }

    final hex = Hexagram(List.of(_lines));
    if (mounted) {
      setState(() {
        _finished = true;
      });
      widget.onComplete?.call(hex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        ..._buildAnimatedLines(),
        const SizedBox(height: 16),
        if (!_finished)
          const Text(
            "Casting hexagram...",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFF8E9BAE),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildAnimatedLines() {
    // Show from top visually, but built bottom-up
    return _lines.reversed.map((line) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: StrokeRevealHexLine(
          isSolid: line.isSolid,
          isChanging: line.isChanging,
          duration: widget.lineRevealDuration,
          changingColor: widget.changingColor,
          lineColor: widget.normalColor,
        ),
      );
    }).toList();
  }
}
