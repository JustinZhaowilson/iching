import 'package:flutter/material.dart';
import 'package:iching/data/hexagram_repository.dart';
import 'package:iching/data/reading_dao.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/models/hexagram.dart';
import 'package:iching/models/reading.dart';
import 'package:iching/models/hex_line_type.dart';
import 'package:iching/components/hexagram_comparison_section.dart';
import 'package:iching/components/reading_question_input.dart';
import 'package:iching/components/hexagram_interpretation_card.dart';
import 'package:iching/components/changing_line_card.dart';
import 'package:iching/components/reading_save_button.dart';

@NowaGenerated()
class ReadingResultScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ReadingResultScreen({super.key});

  @override
  State<ReadingResultScreen> createState() {
    return _ReadingResultScreenState();
  }
}

@NowaGenerated()
class _ReadingResultScreenState extends State<ReadingResultScreen> {
  bool _isInitialized = false;

  final HexagramRepository _repo = HexagramRepository();

  final ReadingDao _readingDao = ReadingDao();

  final TextEditingController _questionController = TextEditingController();

  bool _isFavorite = false;

  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _initRepo();
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _initRepo() async {
    if (!_repo.isInitialized) {
      await _repo.initialize();
    }
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  Future<void> _saveReading(Hexagram hexagram, Hexagram futureHexagram) async {
    final reading = Reading(
      lineValues: hexagram.lines.map((l) => l.type.numericValue).toList(),
      primaryHex: hexagram.number,
      futureHex: futureHexagram.number,
      question: _questionController.text.trim().isEmpty
          ? null
          : _questionController.text.trim(),
      isFavorite: _isFavorite,
    );
    await _readingDao.insertReading(reading);
    if (mounted) {
      setState(() {
        _isSaved = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reading saved to journal!'),
          backgroundColor: Color(0xFF3478F6),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F1419),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};
    final lineValues = args['lineValues'] as List<int>? ?? [];
    if (lineValues.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F1419),
        body: Center(
          child: Text(
            'No reading data provided',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    final hexLines = lineValues.map((v) {
      switch (v) {
        case 6:
          return HexLineType.oldYin;
        case 7:
          return HexLineType.youngYang;
        case 8:
          return HexLineType.youngYin;
        case 9:
          return HexLineType.oldYang;
        default:
          return HexLineType.youngYang;
      }
    }).toList();
    final hexagram = Hexagram.fromTypes(hexLines);
    final futureHexagram = hexagram.deriveFuture();
    final primaryMeta = _repo.getByNumber(hexagram.number);
    final futureMeta = _repo.getByNumber(futureHexagram.number);
    final changingIndices = hexagram.changingLineIndices;
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1419),
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
            icon: Icon(
              _isFavorite ? Icons.bookmark : Icons.bookmark_border,
              color: _isFavorite
                  ? const Color(0xFFFF9500)
                  : const Color(0xFF8E9BAE),
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            HexagramComparisonSection(
              primary: hexagram,
              future: futureHexagram,
            ),
            const SizedBox(height: 32.0),
            ReadingQuestionInput(
              controller: _questionController,
              isSaved: _isSaved,
            ),
            const SizedBox(height: 24.0),
            if (primaryMeta != null) ...[
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
              HexagramInterpretationCard(
                meta: primaryMeta,
                hexagram: hexagram,
                changingIndices: changingIndices,
                isPrimary: true,
              ),
              const SizedBox(height: 16.0),
              if (futureMeta != null && changingIndices.isNotEmpty)
                HexagramInterpretationCard(
                  meta: futureMeta,
                  hexagram: futureHexagram,
                  changingIndices: const [],
                  isPrimary: false,
                ),
              const SizedBox(height: 32.0),
              if (changingIndices.isNotEmpty) ...[
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
                ...changingIndices.map(
                  (idx) => ChangingLineCard(index: idx, meta: primaryMeta),
                ),
              ],
            ],
            const SizedBox(height: 24.0),
            ReadingSaveButton(
              isSaved: _isSaved,
              onSave: () => _saveReading(hexagram, futureHexagram),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
