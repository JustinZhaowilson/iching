import 'package:flutter/material.dart';
import 'package:iching/models/coin_toss.dart';
import 'package:iching/models/hex_line_type.dart';
import 'package:iching/components/stroke_reveal_hex_line.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ReadingProcessScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ReadingProcessScreen({super.key});

  @override
  State<ReadingProcessScreen> createState() => _ReadingProcessScreenState();
}

class _ReadingProcessScreenState extends State<ReadingProcessScreen> {
  final List<HexLineType> _lines = [];
  final CoinTosser _tosser = CoinTosser();
  bool _isComplete = false;

  void _tossCoins() {
    if (_lines.length >= 6) return;

    setState(() {
      final result = _tosser.toss();
      _lines.add(result.toLineType());
      
      if (_lines.length == 6) {
        _isComplete = true;
      }
    });
  }

  void _navigateToResult() {
    Navigator.pushNamed(
      context, 
      'ReadingResultScreen',
      arguments: {
        'lineValues': _lines.map((l) => l.numericValue).toList(),
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f1419),
      appBar: AppBar(
        title: const Text('Cast Hexagram'),
        backgroundColor: const Color(0xff0f1419),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isComplete ? 'Hexagram Complete' : 'Build your Hexagram',
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isComplete 
                        ? 'Wisdom awaits your discovery'
                        : 'Tap the button to toss coins for line ${_lines.length + 1}',
                      style: const TextStyle(color: Color(0xff8e9bae), fontSize: 16),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      width: 280,
                      decoration: BoxDecoration(
                        color: const Color(0xff1c2630),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,

                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Display lines from bottom to top (index 0 is bottom)
                          // Visually top line is the last one in the list
                          for (var i = 5; i >= 0; i--)
                            if (i < _lines.length)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: StrokeRevealHexLine(
                                  key: ValueKey('line_$i'),
                                  isSolid: _lines[i].isSolid,
                                  isChanging: _lines[i].isChanging,
                                  lineColor: const Color(0xffd1d5db),
                                  changingColor: const Color(0xffff9500),
                                ),
                              )
                            else
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                height: 14,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(7),

                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isComplete ? _navigateToResult : _tossCoins,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: _isComplete ? const Color(0xff10b981) : const Color(0xff3478f6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    _isComplete ? 'Reveal Insight' : 'Toss Coins (${_lines.length}/6)',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
