import 'package:flutter/material.dart';
import 'package:iching/data/hexagram_repository.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class MostCommonHexCard extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MostCommonHexCard({
    super.key,
    required this.stats,
    required this.repository,
  });

  final Map<String, dynamic> stats;

  final HexagramRepository repository;

  @override
  Widget build(BuildContext context) {
    final hexNum = stats['most_common_hex'] as int?;
    final meta = hexNum != null ? repository.getByNumber(hexNum) : null;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2630),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Most Frequent Insight',
            style: TextStyle(color: Color(0xFF8E9BAE), fontSize: 14.0),
          ),
          const SizedBox(height: 16.0),
          if (meta != null)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meta.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Hexagram ${meta.number}',
                        style: const TextStyle(
                          color: Color(0xFF3478F6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C3A4A),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    meta.chineseName,
                    style: const TextStyle(color: Colors.white, fontSize: 28.0),
                  ),
                ),
              ],
            )
          else
            const Text(
              'Keep casting to reveal patterns',
              style: TextStyle(color: Color(0xFF3A4556), fontSize: 16.0),
            ),
        ],
      ),
    );
  }
}
