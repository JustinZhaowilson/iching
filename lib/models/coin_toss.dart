import 'dart:math';
import 'hex_line_type.dart';

/// Represents a single coin in the 3-coin method.
enum Coin { heads, tails }

/// Result of tossing 3 coins for one hexagram line.
/// 
/// Classic 3-coin method:
/// - 3 heads (value 9) → old yang (changing solid)
/// - 3 tails (value 6) → old yin (changing broken)
/// - 2 heads 1 tail (7) → young yang (stable solid)
/// - 2 tails 1 head (8) → young yin (stable broken)
class CoinTossResult {
  final List<Coin> coins;
  
  const CoinTossResult(this.coins);
  
  /// Numeric value: heads=3, tails=2, sum ranges 6-9
  int get numericValue {
    int sum = 0;
    for (final c in coins) {
      sum += c == Coin.heads ? 3 : 2;
    }
    return sum;
  }
  
  /// Convert the toss result to an I Ching line type
  HexLineType toLineType() {
    switch (numericValue) {
      case 6:
        return HexLineType.oldYin;
      case 7:
        return HexLineType.youngYang;
      case 8:
        return HexLineType.youngYin;
      case 9:
        return HexLineType.oldYang;
      default:
        throw StateError('Invalid coin sum: $numericValue');
    }
  }
  
  @override
  String toString() => 'CoinTossResult($coins, value: $numericValue)';
}

/// Utility class for performing coin tosses.
class CoinTosser {
  final Random _rng;
  
  CoinTosser({Random? random}) : _rng = random ?? Random();
  
  /// Toss 3 coins and return the result.
  CoinTossResult toss() {
    final coins = List.generate(3, (_) {
      return _rng.nextBool() ? Coin.heads : Coin.tails;
    });
    return CoinTossResult(coins);
  }
  
  /// Generate all 6 lines for a complete hexagram.
  List<HexLineType> generateHexagram() {
    return List.generate(6, (_) => toss().toLineType());
  }
}
