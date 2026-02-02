Line‑by‑line reveal animation (stroke‑draw effect) and

Coin toss → line reveal → hexagram build animation and

A full database model for hexagrams + changing lines


Overview table
Piece	What you get	How it plugs in
Line‑by‑line stroke reveal	Each line “draws itself” into existence	Wraps HexLine rendering
Coin toss → line → hex build	Tosses coins, derives line types, builds hex	Drives your reading flow
Hexagram DB model	Structured data for 64 hexes + lines	Backing store for texts & metadata
1. Line‑by‑line stroke‑draw reveal
We’ll build a reusable widget that:

animates from 0 → 1

draws only a portion of the line based on progress

works for solid and broken lines

can be combined with glow for changing lines

Stroke‑draw line widget
dart
class StrokeRevealHexLine extends StatefulWidget {
  final bool isSolid;
  final bool isChanging;
  final Duration duration;

  const StrokeRevealHexLine({
    super.key,
    required this.isSolid,
    required this.isChanging,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<StrokeRevealHexLine> createState() => _StrokeRevealHexLineState();
}

class _StrokeRevealHexLineState extends State<StrokeRevealHexLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (_, __) {
        final glowOpacity = widget.isChanging ? (0.2 + 0.5 * _progress.value) : 0.0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: glowOpacity > 0
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(glowOpacity),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                )
              : null,
          child: CustomPaint(
            painter: _StrokeRevealPainter(
              isSolid: widget.isSolid,
              color: widget.isChanging ? Colors.orange : Colors.black,
              progress: _progress.value,
            ),
            child: const SizedBox(height: 14),
          ),
        );
      },
    );
  }
}

class _StrokeRevealPainter extends CustomPainter {
  final bool isSolid;
  final Color color;
  final double progress; // 0..1

  _StrokeRevealPainter({
    required this.isSolid,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    if (isSolid) {
      final endX = size.width * progress;
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(endX, size.height / 2),
        paint,
      );
    } else {
      final gap = size.width * 0.18;
      final segment = (size.width - gap) / 2;

      final totalVisible = (segment * 2 + gap) * progress;

      if (totalVisible <= segment) {
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(totalVisible, size.height / 2),
          paint,
        );
      } else if (totalVisible <= segment + gap) {
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(segment, size.height / 2),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(segment, size.height / 2),
          paint,
        );
        final secondVisible = totalVisible - (segment + gap);
        final secondEnd = (secondVisible).clamp(0.0, segment);
        canvas.drawLine(
          Offset(segment + gap, size.height / 2),
          Offset(segment + gap + secondEnd, size.height / 2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StrokeRevealPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.isSolid != isSolid;
}
Using it in HexagramCard
dart
Widget _buildLines() {
  return Column(
    children: lines.reversed.map((line) {
      return StrokeRevealHexLine(
        isSolid: line.isSolid,
        isChanging: line.isChanging,
      );
    }).toList(),
  );
}
2. Coin toss → line reveal → hexagram build
We’ll model:

Coin toss result

Mapping to HexLineType

A controller widget that:

tosses coins per line

reveals each line with stroke animation

then hands off a completed Hexagram

Coin toss + line mapping
Classic 3‑coin method:

3 heads (value 9) → old yang (changing solid)

3 tails (value 6) → old yin (changing broken)

2 heads 1 tail (7) → young yang

2 tails 1 head (8) → young yin

dart
enum Coin { heads, tails }

class CoinTossResult {
  final List<Coin> coins;
  const CoinTossResult(this.coins);

  int get numericValue {
    // heads = 3, tails = 2
    int sum = 0;
    for (final c in coins) {
      sum += c == Coin.heads ? 3 : 2;
    }
    return sum;
  }

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
}

class CoinTosser {
  final Random _rng = Random();

  CoinTossResult toss() {
    List<Coin> coins = List.generate(3, (_) {
      return _rng.nextBool() ? Coin.heads : Coin.tails;
    });
    return CoinTossResult(coins);
  }
}
Line‑by‑line hex build widget
This widget:

builds lines from bottom to top

tosses coins for each line

reveals each line with StrokeRevealHexLine

calls onComplete with the final Hexagram

dart
class HexagramBuilderView extends StatefulWidget {
  final void Function(Hexagram hexagram) onComplete;
  final Duration lineRevealDuration;
  final Duration pauseBetweenLines;

  const HexagramBuilderView({
    super.key,
    required this.onComplete,
    this.lineRevealDuration = const Duration(milliseconds: 700),
    this.pauseBetweenLines = const Duration(milliseconds: 300),
  });

  @override
  State<HexagramBuilderView> createState() => _HexagramBuilderViewState();
}

class _HexagramBuilderViewState extends State<HexagramBuilderView> {
  final CoinTosser _tosser = CoinTosser();
  final List<HexLine> _lines = [];
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _startBuilding();
  }

  Future<void> _startBuilding() async {
    for (int i = 0; i < 6; i++) {
      final toss = _tosser.toss();
      final type = toss.toLineType();
      final line = HexLine(type);

      setState(() {
        _lines.add(line);
      });

      await Future.delayed(
        widget.lineRevealDuration + widget.pauseBetweenLines,
      );
    }

    final hex = Hexagram(List.of(_lines));
    setState(() {
      _finished = true;
    });
    widget.onComplete(hex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ..._buildAnimatedLines(),
        const SizedBox(height: 16),
        if (!_finished)
          const Text("Casting hexagram...", style: TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }

  List<Widget> _buildAnimatedLines() {
    // show from top visually, but built bottom-up
    return _lines.reversed.map((line) {
      return StrokeRevealHexLine(
        isSolid: line.isSolid,
        isChanging: line.isChanging,
        duration: widget.lineRevealDuration,
      );
    }).toList();
  }
}
Plugging into your flow
dart
HexagramBuilderView(
  onComplete: (primaryHex) {
    final futureHex = primaryHex.deriveFuture();
    // Navigate to AnimatedReadingView with primaryHex + futureHex
  },
);
You can wrap this in a “coin toss” screen (with coin animations) and then transition into this builder view, then into your reading view.

3. Full database model for hexagrams + changing lines
You want a structure that can:

store all 64 hexagrams

store line texts (including changing line texts)

be serializable (JSON / local DB)

integrate with your Hexagram + HexLine model

Dart data model
dart
class HexagramMeta {
  final int number;              // 1..64
  final String name;             // "Youthful Folly"
  final String chineseName;      // "蒙"
  final String pinyin;           // "Méng"
  final String judgment;         // main text
  final String image;            // image text
  final List<LineText> lines;    // 6 entries, bottom..top

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
}

class LineText {
  final int position;          // 1..6 (1 = bottom)
  final String baseText;       // normal line text
  final String? changingText;  // optional changing-line commentary

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
Example JSON entry (for one hexagram)
json
{
  "number": 4,
  "name": "Youthful Folly",
  "chineseName": "蒙",
  "pinyin": "Méng",
  "judgment": "Youthful folly has success. It is not I who seek the young fool; the young fool seeks me...",
  "image": "A spring wells up at the foot of the mountain...",
  "lines": [
    {
      "position": 1,
      "baseText": "To make a fool develop, it furthers to apply discipline.",
      "changingText": "If you are too harsh, you may break the spirit."
    },
    {
      "position": 2,
      "baseText": "To bear with fools in kindness brings good fortune.",
      "changingText": null
    }
    // ... up to position 6
  ]
}
Lookup helper
You can keep a Map<int, HexagramMeta> in memory or load from a local JSON file:

dart
class HexagramRepository {
  final Map<int, HexagramMeta> _byNumber;

  HexagramRepository(this._byNumber);

  HexagramMeta? getByNumber(int number) => _byNumber[number];
}
Then, when you’ve cast a Hexagram and know which lines are changing, you can:

fetch HexagramMeta by number

pick out LineText for each changing line

show changingText if present, else baseText