import 'package:flutter/material.dart';
import 'package:iching/models/hexagram_meta.dart';
import 'package:iching/models/hexagram.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramInterpretationCard extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramInterpretationCard({
    super.key,
    required this.meta,
    required this.hexagram,
    required this.changingIndices,
    required this.isPrimary,
  });

  final HexagramMeta meta;

  final Hexagram hexagram;

  final List<int> changingIndices;

  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2630),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: isPrimary
                      ? const Color(0xFF2C3A4A)
                      : const Color(0xFF1E3A5F),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  isPrimary ? 'PRIMARY' : 'FUTURE',
                  style: TextStyle(
                    color: isPrimary
                        ? const Color(0xFF8E9BAE)
                        : const Color(0xFF3478F6),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                'Hexagram ${meta.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C3A4A),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  isPrimary ? Icons.eco_outlined : Icons.water_drop_outlined,
                  color: const Color(0xFF8E9BAE),
                  size: 20.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            meta.name,
            style: const TextStyle(
              color: Color(0xFF3478F6),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            meta.judgment,
            style: const TextStyle(
              color: Color(0xFF8E9BAE),
              fontSize: 15.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'HexagramDetailScreen',
                  arguments: {
                    'hexagramNumber': meta.number,
                    'changingLinePositions': isPrimary
                        ? changingIndices.map((i) => i + 1).toList()
                        : <int>[],
                    'isFuture': !isPrimary,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPrimary
                    ? const Color(0xFF3478F6)
                    : const Color(0xFF2C3A4A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0.0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Read Full Meaning',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, size: 18.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
