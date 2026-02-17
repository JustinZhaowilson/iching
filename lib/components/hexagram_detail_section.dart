import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramDetailSection extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramDetailSection({
    super.key,
    required this.title,
    required this.content,
    required this.themeColor,
  });

  final String title;

  final String content;

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
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          content,
          style: const TextStyle(
            color: Color(0xFFCCD6E3),
            fontSize: 16.0,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
