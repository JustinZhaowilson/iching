import 'package:flutter/material.dart';
import 'package:iching/data/reading_dao.dart';
import 'package:iching/data/hexagram_repository.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/components/stat_card.dart';
import 'package:iching/components/most_common_hex_card.dart';

@NowaGenerated()
class StatsScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() {
    return _StatsScreenState();
  }
}

@NowaGenerated()
class _StatsScreenState extends State<StatsScreen> {
  final ReadingDao _readingDao = ReadingDao();

  final HexagramRepository _repo = HexagramRepository();

  Map<String, dynamic> _stats = {};

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _loading = true);
    if (!_repo.isInitialized) {
      await _repo.initialize();
    }
    final stats = await _readingDao.getStats();
    if (mounted) {
      setState(() {
        _stats = stats;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1419),
        elevation: 0.0,
        title: const Text(
          'Statistics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatCard(
                    title: 'Total Readings',
                    value: _stats['total'].toString(),
                    icon: Icons.auto_awesome,
                    color: const Color(0xFF3478F6),
                  ),
                  const SizedBox(height: 16.0),
                  StatCard(
                    title: 'Favorites Saved',
                    value: _stats['favorites'].toString(),
                    icon: Icons.bookmark,
                    color: const Color(0xFFFF9500),
                  ),
                  const SizedBox(height: 16.0),
                  MostCommonHexCard(stats: _stats, repository: _repo),
                  const SizedBox(height: 32.0),
                  const Center(
                    child: Text(
                      'Your journey with the I Ching is personal.\nThese stats reflect your path of inquiry.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF3A4556),
                        fontSize: 13.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
