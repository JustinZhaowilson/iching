# Feature 02: Stroke Animation

**Priority:** High  
**Dependencies:** `01-data-models`  
**Estimated Effort:** Medium

---

## Overview

Animated line-by-line stroke reveal effect for hexagram visualization.

## Files to Create

| File | Location | Purpose |
|------|----------|---------|
| `stroke_reveal_hex_line.dart` | `lib/widgets/` | Animated line widget |
| `stroke_reveal_painter.dart` | `lib/widgets/` | Custom painter for stroke effect |

---

## Implementation Details

### StrokeRevealHexLine Widget

A `StatefulWidget` that:
- Animates line drawing from 0% → 100%
- Supports solid and broken line types
- Applies glow effect for changing lines

**Key Properties:**
```dart
final bool isSolid;
final bool isChanging;
final Duration duration; // default: 600ms
```

**Animation Behavior:**
- Uses `CurvedAnimation` with `Curves.easeOutCubic`
- Changing lines get orange glow with increasing opacity
- Non-changing lines are rendered in black

### StrokeRevealPainter

Custom painter that:
- Draws solid lines as single stroke
- Draws broken lines as two segments with 18% gap
- Respects animation progress (0..1)

**Paint Logic:**
```dart
if (isSolid) {
  // Single line from start to (width * progress)
} else {
  // Two segments with gap, revealed progressively
}
```

---

## Usage Example

```dart
StrokeRevealHexLine(
  isSolid: line.isSolid,
  isChanging: line.isChanging,
  duration: Duration(milliseconds: 700),
)
```

---

## Acceptance Criteria

- [ ] Animation plays smoothly on first render
- [ ] Broken lines reveal correctly with gap
- [ ] Changing lines have orange glow
- [ ] Widget is reusable across screens
