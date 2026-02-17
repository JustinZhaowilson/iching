import 'dart:convert';

class Reading {
  final int? id;
  final DateTime createdAt;
  final List<int> lineValues;
  final int primaryHex;
  final int futureHex;
  final String? question;
  final bool isFavorite;

  Reading({
    this.id,
    DateTime? createdAt,
    required this.lineValues,
    required this.primaryHex,
    required this.futureHex,
    this.question,
    this.isFavorite = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'line_values': jsonEncode(lineValues),
      'primary_hex': primaryHex,
      'future_hex': futureHex,
      'question': question,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  factory Reading.fromMap(Map<String, dynamic> map) {
    return Reading(
      id: map['id'] as int?,
      createdAt: DateTime.parse(map['created_at'] as String),
      lineValues: (jsonDecode(map['line_values'] as String) as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      primaryHex: map['primary_hex'] as int,
      futureHex: map['future_hex'] as int,
      question: map['question'] as String?,
      isFavorite: (map['is_favorite'] as int) == 1,
    );
  }
}
