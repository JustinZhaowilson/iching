import 'hex_line_type.dart';

/// Represents a single line in a hexagram with full I Ching semantics.
class HexLine {
  final HexLineType type;
  
  const HexLine(this.type);
  
  /// Whether this line is solid (yang)
  bool get isSolid => type.isSolid;
  
  /// Whether this line is broken (yin)
  bool get isBroken => type.isBroken;
  
  /// Whether this is a changing line
  bool get isChanging => type.isChanging;
  
  /// The numeric value (6-9)
  int get numericValue => type.numericValue;
  
  /// Transform this line (for deriving future hexagram)
  HexLine get transformed => HexLine(type.transformed);
  
  @override
  String toString() => 'HexLine($type)';
}

/// A complete hexagram with 6 lines.
/// 
/// Lines are stored bottom-to-top (index 0 = bottom line, index 5 = top).
class Hexagram {
  final List<HexLine> lines;
  
  const Hexagram(this.lines) : assert(lines.length == 6);
  
  /// Create a hexagram from line types
  factory Hexagram.fromTypes(List<HexLineType> types) {
    return Hexagram(types.map((t) => HexLine(t)).toList());
  }
  
  /// Whether this hexagram has any changing lines
  bool get hasChangingLines => lines.any((l) => l.isChanging);
  
  /// Get indices of changing lines (0-5, bottom to top)
  List<int> get changingLineIndices {
    return [
      for (int i = 0; i < 6; i++)
        if (lines[i].isChanging) i
    ];
  }
  
  /// Derive the future hexagram by transforming all changing lines
  Hexagram deriveFuture() {
    return Hexagram(lines.map((l) => l.transformed).toList());
  }
  
  /// Calculate the hexagram number (1-64) from the binary pattern.
  /// 
  /// Uses the King Wen sequence ordering.
  int get number {
    // Convert to binary pattern first, then map to King Wen number
    final binaryValue = _toBinaryValue();
    return _kingWenSequence[binaryValue] ?? 1;
  }
  
  /// Convert lines to a 6-bit binary value (0-63)
  int _toBinaryValue() {
    int value = 0;
    for (int i = 0; i < 6; i++) {
      if (lines[i].isSolid) {
        value |= (1 << i);
      }
    }
    return value;
  }
  
  @override
  String toString() => 'Hexagram(#$number, lines: $lines)';
  
  /// King Wen sequence: maps binary value (0-63) to hexagram number (1-64)
  static const Map<int, int> _kingWenSequence = {
    0: 2,   // ䷁ Kun (The Receptive)
    1: 24,  // ䷗ Fu (Return)
    2: 7,   // ䷆ Shi (The Army)
    3: 19,  // ䷒ Lin (Approach)
    4: 15,  // ䷎ Qian (Modesty)
    5: 36,  // ䷣ Ming Yi (Darkening)
    6: 46,  // ䷭ Sheng (Pushing Upward)
    7: 11,  // ䷊ Tai (Peace)
    8: 16,  // ䷏ Yu (Enthusiasm)
    9: 51,  // ䷲ Zhen (The Arousing)
    10: 40, // ䷧ Jie (Deliverance)
    11: 54, // ䷵ Gui Mei
    12: 62, // ䷽ Xiao Guo
    13: 55, // ䷶ Feng (Abundance)
    14: 32, // ䷟ Heng (Duration)
    15: 34, // ䷡ Da Zhuang
    16: 8,  // ䷇ Bi (Holding Together)
    17: 3,  // ䷂ Zhun (Difficulty)
    18: 29, // ䷜ Kan (The Abysmal)
    19: 60, // ䷻ Jie (Limitation)
    20: 39, // ䷦ Jian (Obstruction)
    21: 63, // ䷾ Ji Ji (After Completion)
    22: 48, // ䷯ Jing (The Well)
    23: 5,  // ䷄ Xu (Waiting)
    24: 45, // ䷬ Cui (Gathering)
    25: 17, // ䷐ Sui (Following)
    26: 47, // ䷮ Kun (Oppression)
    27: 58, // ䷹ Dui (The Joyous)
    28: 31, // ䷞ Xian (Influence)
    29: 49, // ䷰ Ge (Revolution)
    30: 28, // ䷛ Da Guo (Preponderance)
    31: 43, // ䷪ Guai (Breakthrough)
    32: 23, // ䷖ Bo (Splitting Apart)
    33: 27, // ䷚ Yi (Nourishment)
    34: 4,  // ䷃ Meng (Youthful Folly)
    35: 41, // ䷨ Sun (Decrease)
    36: 52, // ䷳ Gen (Keeping Still)
    37: 22, // ䷕ Bi (Grace)
    38: 18, // ䷑ Gu (Decay)
    39: 26, // ䷙ Da Chu
    40: 35, // ䷢ Jin (Progress)
    41: 21, // ䷔ Shi He (Biting Through)
    42: 64, // ䷿ Wei Ji (Before Completion)
    43: 38, // ䷥ Kui (Opposition)
    44: 56, // ䷷ Lu (The Wanderer)
    45: 30, // ䷝ Li (The Clinging)
    46: 50, // ䷱ Ding (The Cauldron)
    47: 14, // ䷍ Da You (Great Possession)
    48: 20, // ䷓ Guan (Contemplation)
    49: 42, // ䷩ Yi (Increase)
    50: 59, // ䷺ Huan (Dispersion)
    51: 61, // ䷼ Zhong Fu
    52: 53, // ䷴ Jian (Development)
    53: 37, // ䷤ Jia Ren (The Family)
    54: 57, // ䷸ Xun (The Gentle)
    55: 9,  // ䷈ Xiao Chu
    56: 12, // ䷋ Pi (Standstill)
    57: 25, // ䷘ Wu Wang
    58: 6,  // ䷅ Song (Conflict)
    59: 10, // ䷉ Lu (Treading)
    60: 33, // ䷠ Dun (Retreat)
    61: 13, // ䷌ Tong Ren
    62: 44, // ䷫ Gou (Coming to Meet)
    63: 1,  // ䷀ Qian (The Creative)
  };
}
