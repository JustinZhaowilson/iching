import 'package:flutter/material.dart';
import 'package:iching/data/reading_dao.dart';
import 'package:iching/data/hexagram_repository.dart';
import 'package:iching/models/reading.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/components/journal_empty_state.dart';
import 'package:iching/components/journal_reading_card.dart';

@NowaGenerated()
class JournalScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() {
    return _JournalScreenState();
  }
}

@NowaGenerated()
class _JournalScreenState extends State<JournalScreen> {
  final ReadingDao _readingDao = ReadingDao();

  final HexagramRepository _repo = HexagramRepository();

  List<Reading> _readings = [];

  bool _loading = true;

  bool _showOnlyFavorites = false;

  @override
  void initState() {
    super.initState();
    _loadReadings();
  }

  Future<void> _loadReadings() async {
    setState(() => _loading = true);
    if (!_repo.isInitialized) {
      await _repo.initialize();
    }
    final readings = _showOnlyFavorites
        ? await _readingDao.getFavorites()
        : await _readingDao.getAllReadings();
    if (mounted) {
      setState(() {
        _readings = readings;
        _loading = false;
      });
    }
  }

  Future<void> _deleteReading(Reading reading) async {
    if (reading.id == null) {
      return;
    }
    await _readingDao.deleteReading(reading.id!);
    _loadReadings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1419),
        elevation: 0.0,
        title: const Text(
          'Journal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _showOnlyFavorites ? Icons.bookmark : Icons.bookmark_border,
              color: _showOnlyFavorites
                  ? const Color(0xFFFF9500)
                  : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showOnlyFavorites = !_showOnlyFavorites;
              });
              _loadReadings();
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _readings.isEmpty
          ? JournalEmptyState(isFavorites: _showOnlyFavorites)
          : ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: _readings.length,
              itemBuilder: (context, index) {
                final reading = _readings[index];
                return JournalReadingCard(
                  reading: reading,
                  repository: _repo,
                  onDelete: () => _deleteReading(reading),
                );
              },
            ),
    );
  }
}
