import 'package:flutter_test/flutter_test.dart';
import 'package:iching/models/hex_line_type.dart';
import 'package:iching/models/hexagram.dart';
import 'package:iching/models/coin_toss.dart';

void main() {
  group('HexLineType', () {
    test('oldYin should be broken and changing', () {
      expect(HexLineType.oldYin.isBroken, true);
      expect(HexLineType.oldYin.isSolid, false);
      expect(HexLineType.oldYin.isChanging, true);
      expect(HexLineType.oldYin.numericValue, 6);
    });

    test('youngYang should be solid and stable', () {
      expect(HexLineType.youngYang.isSolid, true);
      expect(HexLineType.youngYang.isBroken, false);
      expect(HexLineType.youngYang.isChanging, false);
      expect(HexLineType.youngYang.numericValue, 7);
    });

    test('youngYin should be broken and stable', () {
      expect(HexLineType.youngYin.isBroken, true);
      expect(HexLineType.youngYin.isSolid, false);
      expect(HexLineType.youngYin.isChanging, false);
      expect(HexLineType.youngYin.numericValue, 8);
    });

    test('oldYang should be solid and changing', () {
      expect(HexLineType.oldYang.isSolid, true);
      expect(HexLineType.oldYang.isBroken, false);
      expect(HexLineType.oldYang.isChanging, true);
      expect(HexLineType.oldYang.numericValue, 9);
    });

    test('transformed returns correct opposite for changing lines', () {
      expect(HexLineType.oldYin.transformed, HexLineType.youngYang);
      expect(HexLineType.oldYang.transformed, HexLineType.youngYin);
      expect(HexLineType.youngYang.transformed, HexLineType.youngYang);
      expect(HexLineType.youngYin.transformed, HexLineType.youngYin);
    });
  });

  group('HexLine', () {
    test('isSolid delegates to type', () {
      final solidLine = HexLine(HexLineType.youngYang);
      final brokenLine = HexLine(HexLineType.youngYin);
      
      expect(solidLine.isSolid, true);
      expect(brokenLine.isSolid, false);
    });

    test('isChanging delegates to type', () {
      final changingLine = HexLine(HexLineType.oldYang);
      final stableLine = HexLine(HexLineType.youngYang);
      
      expect(changingLine.isChanging, true);
      expect(stableLine.isChanging, false);
    });

    test('transformed returns new HexLine with transformed type', () {
      final oldYangLine = HexLine(HexLineType.oldYang);
      final transformed = oldYangLine.transformed;
      
      expect(transformed.type, HexLineType.youngYin);
    });
  });

  group('Hexagram', () {
    test('creates with 6 lines', () {
      final lines = [
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
      ];
      
      final hex = Hexagram(lines);
      expect(hex.lines.length, 6);
    });

    test('hasChangingLines returns true when changing lines exist', () {
      final lines = [
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.oldYin), // changing
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
      ];
      
      final hex = Hexagram(lines);
      expect(hex.hasChangingLines, true);
    });

    test('hasChangingLines returns false when no changing lines', () {
      final lines = [
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
      ];
      
      final hex = Hexagram(lines);
      expect(hex.hasChangingLines, false);
    });

    test('changingLineIndices returns correct positions', () {
      final lines = [
        HexLine(HexLineType.youngYang),    // 0
        HexLine(HexLineType.oldYin),       // 1 - changing
        HexLine(HexLineType.youngYang),    // 2
        HexLine(HexLineType.oldYang),      // 3 - changing
        HexLine(HexLineType.youngYang),    // 4
        HexLine(HexLineType.youngYin),     // 5
      ];
      
      final hex = Hexagram(lines);
      expect(hex.changingLineIndices, [1, 3]);
    });

    test('deriveFuture transforms changing lines', () {
      final lines = [
        HexLine(HexLineType.oldYang),  // solid -> broken
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.youngYin),
        HexLine(HexLineType.youngYang),
        HexLine(HexLineType.oldYin),   // broken -> solid
      ];
      
      final hex = Hexagram(lines);
      final future = hex.deriveFuture();
      
      expect(future.lines[0].type, HexLineType.youngYin);
      expect(future.lines[5].type, HexLineType.youngYang);
    });

    test('all solid lines returns hexagram #1 (Qian)', () {
      final lines = List.generate(6, (_) => HexLine(HexLineType.youngYang));
      final hex = Hexagram(lines);
      expect(hex.number, 1);
    });

    test('all broken lines returns hexagram #2 (Kun)', () {
      final lines = List.generate(6, (_) => HexLine(HexLineType.youngYin));
      final hex = Hexagram(lines);
      expect(hex.number, 2);
    });
  });

  group('CoinToss', () {
    test('CoinTossResult calculates correct numeric value', () {
      // 3 heads = 9
      expect(
        CoinTossResult([Coin.heads, Coin.heads, Coin.heads]).numericValue, 
        9,
      );
      
      // 3 tails = 6
      expect(
        CoinTossResult([Coin.tails, Coin.tails, Coin.tails]).numericValue, 
        6,
      );
      
      // 2 heads 1 tail = 8
      expect(
        CoinTossResult([Coin.heads, Coin.heads, Coin.tails]).numericValue, 
        8,
      );
      
      // 2 tails 1 head = 7
      expect(
        CoinTossResult([Coin.tails, Coin.tails, Coin.heads]).numericValue, 
        7,
      );
    });

    test('CoinTossResult maps to correct line types', () {
      expect(
        CoinTossResult([Coin.tails, Coin.tails, Coin.tails]).toLineType(),
        HexLineType.oldYin,
      );
      expect(
        CoinTossResult([Coin.heads, Coin.heads, Coin.heads]).toLineType(),
        HexLineType.oldYang,
      );
    });

    test('CoinTosser generates valid line types', () {
      final tosser = CoinTosser();
      
      for (int i = 0; i < 10; i++) {
        final result = tosser.toss();
        final value = result.numericValue;
        expect(value >= 6 && value <= 9, true);
      }
    });

    test('CoinTosser generates 6 lines for hexagram', () {
      final tosser = CoinTosser();
      final lines = tosser.generateHexagram();
      
      expect(lines.length, 6);
      for (final line in lines) {
        expect(HexLineType.values.contains(line), true);
      }
    });
  });
}
