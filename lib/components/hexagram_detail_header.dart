import 'package:flutter/material.dart';
import 'package:iching/models/hexagram_meta.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramDetailHeader extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramDetailHeader({
    super.key,
    required this.meta,
    required this.themeColor,
  });

  final HexagramMeta meta;

  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2630),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Text(
            'Hexagram ${meta.number}',
            style: const TextStyle(
              color: Color(0xFF8E9BAE),
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            meta.chineseName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            meta.displayName,
            style: TextStyle(
              color: themeColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
