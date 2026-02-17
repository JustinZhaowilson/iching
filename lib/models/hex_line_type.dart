/// Extended line type enum for I Ching hexagram lines.
/// 
/// - `oldYin` (6): Broken line that changes to solid
/// - `youngYang` (7): Solid line that stays solid  
/// - `youngYin` (8): Broken line that stays broken
/// - `oldYang` (9): Solid line that changes to broken
enum HexLineType {
  oldYin,     // 6 - changing broken (becomes solid)
  youngYang,  // 7 - stable solid
  youngYin,   // 8 - stable broken
  oldYang,    // 9 - changing solid (becomes broken)
}

extension HexLineTypeExtension on HexLineType {
  /// Whether this line type is solid (yang)
  bool get isSolid => this == HexLineType.youngYang || this == HexLineType.oldYang;
  
  /// Whether this line type is broken (yin)
  bool get isBroken => this == HexLineType.youngYin || this == HexLineType.oldYin;
  
  /// Whether this line changes in the transformed hexagram
  bool get isChanging => this == HexLineType.oldYin || this == HexLineType.oldYang;
  
  /// The numeric value (6-9) traditionally used in I Ching
  int get numericValue {
    switch (this) {
      case HexLineType.oldYin:
        return 6;
      case HexLineType.youngYang:
        return 7;
      case HexLineType.youngYin:
        return 8;
      case HexLineType.oldYang:
        return 9;
    }
  }
  
  /// Returns the transformed line type (for deriving future hexagram)
  HexLineType get transformed {
    switch (this) {
      case HexLineType.oldYin:
        return HexLineType.youngYang; // broken → solid
      case HexLineType.oldYang:
        return HexLineType.youngYin;  // solid → broken
      case HexLineType.youngYang:
        return HexLineType.youngYang; // stays same
      case HexLineType.youngYin:
        return HexLineType.youngYin;  // stays same
    }
  }
}
