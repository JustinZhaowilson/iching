import 'package:flutter/material.dart';
import 'package:iching/models/hexagram_meta.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramLineDetailCard extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramLineDetailCard({
    super.key,
    required this.line,
    required this.isChanging,
    required this.themeColor,
  });

  final LineText line;

  final bool isChanging;

  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isChanging ? const Color(0xFF2A2418) : const Color(0xFF1C2630),
        borderRadius: BorderRadius.circular(12.0),
        border: isChanging
            ? Border.all(color: const Color(0xFF4A3A28), width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: isChanging ? themeColor : const Color(0xFF2C3A4A),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${line.position}',
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
                'Line ${line.position}',
                style: TextStyle(
                  color: isChanging ? themeColor : Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isChanging) ...[
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: themeColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'CHANGING',
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            line.baseText,
            style: const TextStyle(
              color: Color(0xFFCCD6E3),
              fontSize: 15.0,
              height: 1.5,
            ),
          ),
          if (isChanging && line.changingText != null) ...[
            const SizedBox(height: 8.0),
            Text(
              line.changingText!,
              style: const TextStyle(
                color: Color(0xFF8E9BAE),
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
