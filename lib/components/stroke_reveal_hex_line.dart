import 'package:flutter/material.dart';

/// A hexagram line widget that animates a stroke-draw reveal effect.
/// 
/// The line "draws itself" from left to right, supporting both
/// solid (yang) and broken (yin) lines, with an optional glow
/// effect for changing lines.
class StrokeRevealHexLine extends StatefulWidget {
  final bool isSolid;
  final bool isChanging;
  final Duration duration;
  final Color? changingColor;
  final Color lineColor;

  const StrokeRevealHexLine({
    super.key,
    required this.isSolid,
    this.isChanging = false,
    this.duration = const Duration(milliseconds: 600),
    this.changingColor,
    this.lineColor = const Color(0xFFD1D5DB),
  });

  @override
  State<StrokeRevealHexLine> createState() => _StrokeRevealHexLineState();
}

class _StrokeRevealHexLineState extends State<StrokeRevealHexLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.isChanging
        ? (widget.changingColor ?? Colors.orange)
        : widget.lineColor;

    return AnimatedBuilder(
      animation: _progress,
      builder: (_, __) {
        final glowOpacity = widget.isChanging ? (0.2 + 0.5 * _progress.value) : 0.0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: glowOpacity > 0
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: effectiveColor.withValues(alpha: glowOpacity),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                )
              : null,
          child: CustomPaint(
            painter: _StrokeRevealPainter(
              isSolid: widget.isSolid,
              color: effectiveColor,
              progress: _progress.value,
            ),
            child: const SizedBox(height: 14, width: double.infinity),
          ),
        );
      },
    );
  }
}

/// CustomPainter that draws a hexagram line with progressive reveal.
class _StrokeRevealPainter extends CustomPainter {
  final bool isSolid;
  final Color color;
  final double progress; // 0..1

  _StrokeRevealPainter({
    required this.isSolid,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    if (isSolid) {
      // Solid line: draw from left edge to progress point
      final endX = size.width * progress;
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(endX, size.height / 2),
        paint,
      );
    } else {
      // Broken line: two segments with a gap in the middle
      final gap = size.width * 0.18; // 18% gap
      final segment = (size.width - gap) / 2;
      final totalLength = segment * 2 + gap;
      final totalVisible = totalLength * progress;

      if (totalVisible <= segment) {
        // Still drawing first segment
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(totalVisible, size.height / 2),
          paint,
        );
      } else if (totalVisible <= segment + gap) {
        // First segment complete, in the gap
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(segment, size.height / 2),
          paint,
        );
      } else {
        // Drawing second segment
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(segment, size.height / 2),
          paint,
        );
        final secondVisible = totalVisible - (segment + gap);
        final secondEnd = secondVisible.clamp(0.0, segment);
        canvas.drawLine(
          Offset(segment + gap, size.height / 2),
          Offset(segment + gap + secondEnd, size.height / 2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StrokeRevealPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.isSolid != isSolid;
}
