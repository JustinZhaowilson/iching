# Feature 03: Coin Toss & Hexagram Build

**Priority:** High  
**Dependencies:** `01-data-models`, `02-stroke-animation`  
**Estimated Effort:** Medium

---

## Overview

Coin toss logic and animated hexagram builder that constructs a hexagram line-by-line.

## Files to Create

| File | Location | Purpose |
|------|----------|---------|
| `coin.dart` | `lib/models/` | Coin enum and toss result |
| `coin_tosser.dart` | `lib/services/` | Random coin toss service |
| `hexagram_builder_view.dart` | `lib/widgets/` | Animated hex builder widget |

---

## Implementation Details

### Coin Toss System

**Classic 3-Coin Method:**
| Result | Value | Line Type |
|--------|-------|-----------|
| 3 heads | 9 | Old Yang (changing solid) |
| 3 tails | 6 | Old Yin (changing broken) |
| 2 heads, 1 tail | 7 | Young Yang (solid) |
| 2 tails, 1 head | 8 | Young Yin (broken) |

```dart
enum Coin { heads, tails }

class CoinTossResult {
  final List<Coin> coins;
  
  int get numericValue {
    // heads = 3, tails = 2
    return coins.fold(0, (sum, c) => sum + (c == Coin.heads ? 3 : 2));
  }
  
  HexLineType toLineType() { ... }
}
```

### CoinTosser Service

```dart
class CoinTosser {
  final Random _rng = Random();
  
  CoinTossResult toss() {
    return CoinTossResult(
      List.generate(3, (_) => _rng.nextBool() ? Coin.heads : Coin.tails)
    );
  }
}
```

### HexagramBuilderView Widget

A `StatefulWidget` that:
1. Tosses coins for each of 6 lines (bottom to top)
2. Reveals each line with `StrokeRevealHexLine`
3. Calls `onComplete` with the final `Hexagram`

**Key Properties:**
```dart
final void Function(Hexagram) onComplete;
final Duration lineRevealDuration;  // default: 700ms
final Duration pauseBetweenLines;   // default: 300ms
```

---

## Usage Example

```dart
HexagramBuilderView(
  onComplete: (primaryHex) {
    final futureHex = primaryHex.deriveFuture();
    // Navigate to reading view
  },
)
```

---

## Acceptance Criteria

- [ ] Coin toss produces valid line types
- [ ] Lines build from bottom to top
- [ ] Animation plays sequentially with pauses
- [ ] `onComplete` called with valid hexagram
