import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iching/components/hexagram_widget.dart';
import 'package:iching/hexagram_line.dart';
import 'package:iching/line_type.dart';

void main() {
  testWidgets('HexagramWidget renders correctly', (WidgetTester tester) async {
    // 1. Prepare data
    final lines = [
      HexagramLine(type: LineType.solid, isChanging: true, changingColor: Colors.orange),
      HexagramLine(type: LineType.broken),
      HexagramLine(type: LineType.solid),
      HexagramLine(type: LineType.broken),
      HexagramLine(type: LineType.solid),
      HexagramLine(type: LineType.broken),
    ];

    // 2. Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: HexagramWidget(lines: lines),
          ),
        ),
      ),
    );

    // 3. Verify presence
    expect(find.byType(HexagramWidget), findsOneWidget);

    // 4. Verify line count (should be 6)
    // We expect 6 rows of lines. 
    // Solid line = 1 Expanded container with Row
    // Broken line = 2 Expanded containers with Row
    // Mixed: 3 solid, 3 broken => 3*1 + 3*2 = 9 Expanded containers total inside HexagramWidget
    expect(find.descendant(of: find.byType(HexagramWidget), matching: find.byType(Expanded)), findsNWidgets(9));

    // 5. Verify changing marker
    expect(find.text('×'), findsOneWidget);
  });
}
