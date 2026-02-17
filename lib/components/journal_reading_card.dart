import 'package:flutter/material.dart';
import 'package:iching/models/reading.dart';
import 'package:iching/data/hexagram_repository.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:intl/intl.dart';
import 'package:iching/components/mini_hexagram_widget.dart';

@NowaGenerated()
class JournalReadingCard extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const JournalReadingCard({
    super.key,
    required this.reading,
    required this.repository,
    required this.onDelete,
  });

  final Reading reading;

  final HexagramRepository repository;

  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final primaryMeta = repository.getByNumber(reading.primaryHex);
    final dateStr = DateFormat('MMMM dd, yyyy').format(reading.createdAt);
    final timeStr = DateFormat('jm').format(reading.createdAt);
    return Dismissible(
      key: Key(reading.id!.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.red),
      ),
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            'ReadingResultScreen',
            arguments: {'lineValues': reading.lineValues},
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1C2630),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              MiniHexagramWidget(lineValues: reading.lineValues),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          dateStr,
                          style: const TextStyle(
                            color: Color(0xFF8E9BAE),
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '• $timeStr',
                          style: const TextStyle(
                            color: Color(0xFF3A4556),
                            fontSize: 12.0,
                          ),
                        ),
                        const Spacer(),
                        if (reading.isFavorite)
                          const Icon(
                            Icons.bookmark,
                            color: Color(0xFFFF9500),
                            size: 16.0,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      primaryMeta?.name ?? 'Hexagram ${reading.primaryHex}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (reading.question != null) ...[
                      const SizedBox(height: 6.0),
                      Text(
                        reading.question!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFCCD6E3),
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF2C3A4A)),
            ],
          ),
        ),
      ),
    );
  }
}
