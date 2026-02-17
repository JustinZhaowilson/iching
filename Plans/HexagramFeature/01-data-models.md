# Feature 01: Data Models

**Priority:** High  
**Dependencies:** None  
**Estimated Effort:** Small

---

## Overview

Foundation models for hexagrams, lines, and metadata storage.

## Files to Create

| File | Location | Purpose |
|------|----------|---------|
| `hex_line_type.dart` | `lib/models/` | Enum for line types |
| `hex_line.dart` | `lib/models/` | Line model with type helpers |
| `hexagram.dart` | `lib/models/` | Hexagram model with derive logic |
| `hexagram_meta.dart` | `lib/models/` | Metadata for all 64 hexagrams |
| `line_text.dart` | `lib/models/` | Line text model |
| `hexagram_repository.dart` | `lib/repositories/` | JSON loading/lookup |

---

## Implementation Details

### HexLineType Enum

```dart
enum HexLineType {
  oldYin,    // 6 - changing broken
  youngYang, // 7 - solid
  youngYin,  // 8 - broken
  oldYang,   // 9 - changing solid
}
```

### HexLine Model

```dart
class HexLine {
  final HexLineType type;

  bool get isSolid => type == HexLineType.youngYang || type == HexLineType.oldYang;
  bool get isChanging => type == HexLineType.oldYin || type == HexLineType.oldYang;
}
```

### HexagramMeta Model

```dart
class HexagramMeta {
  final int number;           // 1..64
  final String name;          // "Youthful Folly"
  final String chineseName;   // "蒙"
  final String pinyin;        // "Méng"
  final String judgment;
  final String image;
  final List<LineText> lines; // 6 entries
}
```

### LineText Model

```dart
class LineText {
  final int position;         // 1..6 (1 = bottom)
  final String baseText;
  final String? changingText;
}
```

### HexagramRepository

```dart
class HexagramRepository {
  final Map<int, HexagramMeta> _byNumber;
  
  HexagramMeta? getByNumber(int number) => _byNumber[number];
}
```

---

## Acceptance Criteria

- [ ] All models serialize/deserialize to JSON
- [ ] Repository can load from `assets/hexagrams.json`
- [ ] Unit tests for line type logic
- [ ] Unit tests for hexagram derivation
