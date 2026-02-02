import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/components/hexagram_widget.dart';
import 'package:iching/hexagram_line.dart';
import 'package:iching/line_type.dart';

@NowaGenerated()
class ReadingResultScreen extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ReadingResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f1419),
      appBar: AppBar(
        backgroundColor: const Color(0xff0f1419),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reading Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Color(0xff8e9bae)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            _buildHexagramSection(),
            const SizedBox(height: 32.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Interpretation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildPrimaryHexagramCard(),
            const SizedBox(height: 16.0),
            _buildFutureHexagramCard(),
            const SizedBox(height: 32.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Changing Lines',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildChangingLineCard(),
            const SizedBox(height: 24.0),
            _buildSaveButton(context),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHexagramSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'PRESENT',
                  style: TextStyle(
                    color: Color(0xff8e9bae),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16.0),
                HexagramWidget(
                  lines: [
                    HexagramLine(type: LineType.broken),
                    HexagramLine(type: LineType.solid),
                    HexagramLine(type: LineType.broken),
                    HexagramLine(type: LineType.broken),
                    HexagramLine(
                      type: LineType.solid,
                      isChanging: true,
                      changingColor: const Color(0xffff9500),
                    ),
                    HexagramLine(type: LineType.solid),
                  ],
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Hex 4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          const Icon(Icons.arrow_forward, color: Color(0xff3a4556), size: 28.0),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'FUTURE',
                  style: TextStyle(
                    color: Color(0xff8e9bae),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16.0),
                HexagramWidget(
                  lines: [
                    HexagramLine(type: LineType.broken),
                    HexagramLine(type: LineType.broken),
                    HexagramLine(type: LineType.broken),
                    HexagramLine(type: LineType.broken),
                    HexagramLine(
                      type: LineType.solid,
                      isChanging: true,
                      changingColor: const Color(0xff3478f6),
                    ),
                    HexagramLine(type: LineType.solid),
                  ],
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Hex 29',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryHexagramCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xff1c2630),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff2c3a4a),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'PRIMARY',
                  style: TextStyle(
                    color: Color(0xff8e9bae),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Hexagram 4',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0xff2c3a4a),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.eco_outlined,
                  color: Color(0xff8e9bae),
                  size: 20.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Youthful Folly (Meng)',
            style: TextStyle(
              color: Color(0xff3478f6),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'A mountain spring flows at the foot of a high mountain. The young fool seeks me. Success. It is advantageous to be firm and correct.',
            style: TextStyle(
              color: Color(0xff8e9bae),
              fontSize: 15.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3478f6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0.0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Read Full Meaning',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, size: 18.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFutureHexagramCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xff1c2630),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff1e3a5f),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Text(
                  'FUTURE',
                  style: TextStyle(
                    color: Color(0xff3478f6),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Hexagram 29',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0xff2c3a4a),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.water_drop_outlined,
                  color: Color(0xff8e9bae),
                  size: 20.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'The Abysmal (Kan)',
            style: TextStyle(
              color: Color(0xff3478f6),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Water flows on uninterruptedly and reaches its goal. If you are sincere, you have success in your heart, and whatever you do succeeds.',
            style: TextStyle(
              color: Color(0xff8e9bae),
              fontSize: 15.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2c3a4a),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0.0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Read Full Meaning',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, size: 18.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangingLineCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xff2a2418),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xff4a3a28), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: const BoxDecoration(
                  color: Color(0xffff9500),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '6',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'Line 5 (6 at 5th place)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            '"Childlike folly brings good fortune."',
            style: TextStyle(color: Colors.white, fontSize: 15.0, height: 1.5),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'This implies an attitude of openness and lack of prejudice.',
            style: TextStyle(
              color: Color(0xff8e9bae),
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0.0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.bookmark, size: 20.0),
              SizedBox(width: 10.0),
              Text(
                'Save to Journal',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
