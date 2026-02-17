import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class JournalEmptyState extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const JournalEmptyState({super.key, required this.isFavorites});

  final bool isFavorites;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFavorites ? Icons.bookmark_border : Icons.history_edu,
            size: 64.0,
            color: const Color(0xFF1C2630),
          ),
          const SizedBox(height: 16.0),
          Text(
            isFavorites ? 'No favorite readings yet' : 'Your journal is empty',
            style: const TextStyle(color: Color(0xFF8E9BAE), fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Cast a reading to begin your journey',
            style: TextStyle(color: Color(0xFF3A4556), fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
