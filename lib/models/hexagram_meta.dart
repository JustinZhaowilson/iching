/// Metadata for a single line's text content.
class LineText {
  final int position;         // 1-6 (1 = bottom)
  final String baseText;      // Main line text
  final String? changingText; // Optional changing-line commentary
  
  const LineText({
    required this.position,
    required this.baseText,
    this.changingText,
  });
  
  factory LineText.fromJson(Map<String, dynamic> json) {
    return LineText(
      position: json['position'] as int,
      baseText: json['baseText'] as String,
      changingText: json['changingText'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'position': position,
    'baseText': baseText,
    'changingText': changingText,
  };
}

/// Complete metadata for one of the 64 hexagrams.
class HexagramMeta {
  final int number;           // 1-64
  final String name;          // English name ("Youthful Folly")
  final String chineseName;   // Chinese character ("蒙")
  final String pinyin;        // Romanized pronunciation ("Méng")
  final String judgment;      // King's judgment text
  final String image;         // Image/symbol text
  final List<LineText> lines; // 6 entries, bottom to top
  
  const HexagramMeta({
    required this.number,
    required this.name,
    required this.chineseName,
    required this.pinyin,
    required this.judgment,
    required this.image,
    required this.lines,
  });
  
  factory HexagramMeta.fromJson(Map<String, dynamic> json) {
    return HexagramMeta(
      number: json['number'] as int,
      name: json['name'] as String,
      chineseName: json['chineseName'] as String,
      pinyin: json['pinyin'] as String,
      judgment: json['judgment'] as String,
      image: json['image'] as String,
      lines: (json['lines'] as List<dynamic>)
          .map((e) => LineText.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  
  Map<String, dynamic> toJson() => {
    'number': number,
    'name': name,
    'chineseName': chineseName,
    'pinyin': pinyin,
    'judgment': judgment,
    'image': image,
    'lines': lines.map((l) => l.toJson()).toList(),
  };
  
  /// Format the name with pinyin, e.g. "Youthful Folly (Méng)"
  String get displayName => '$name ($pinyin)';
}
