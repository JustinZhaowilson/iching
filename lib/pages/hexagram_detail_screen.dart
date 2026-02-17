import 'package:flutter/material.dart';
import 'package:iching/models/hexagram_meta.dart';
import 'package:iching/data/note_dao.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/data/hexagram_repository.dart';
import 'package:iching/models/note.dart';
import 'package:iching/components/hexagram_not_found_view.dart';
import 'package:iching/components/hexagram_detail_header.dart';
import 'package:iching/components/hexagram_detail_section.dart';
import 'package:iching/components/hexagram_lines_section.dart';
import 'package:iching/components/hexagram_notes_section.dart';

@NowaGenerated()
class HexagramDetailScreen extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramDetailScreen({
    super.key,
    required this.hexagramNumber,
    this.changingLinePositions,
    this.isFuture = false,
  });

  final int hexagramNumber;

  final List<int>? changingLinePositions;

  final bool isFuture;

  @override
  State<HexagramDetailScreen> createState() {
    return _HexagramDetailScreenState();
  }
}

@NowaGenerated()
class _HexagramDetailScreenState extends State<HexagramDetailScreen> {
  HexagramMeta? _hexagramMeta;

  bool _loading = true;

  final NoteDao _noteDao = NoteDao();

  final TextEditingController _noteController = TextEditingController();

  bool _isSavingNote = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final repo = HexagramRepository();
    if (!repo.isInitialized) {
      await repo.initialize();
    }
    final note = await _noteDao.getNoteForHexagram(widget.hexagramNumber);
    if (mounted) {
      setState(() {
        _hexagramMeta = repo.getByNumber(widget.hexagramNumber);
        if (note != null) {
          _noteController.text = note.content;
        }
        _loading = false;
      });
    }
  }

  Future<void> _saveNote() async {
    setState(() {
      _isSavingNote = true;
    });
    final note = Note(
      hexagramNum: widget.hexagramNumber,
      content: _noteController.text.trim(),
    );
    if (_noteController.text.trim().isEmpty) {
      await _noteDao.deleteNote(widget.hexagramNumber);
    } else {
      await _noteDao.upsertNote(note);
    }
    if (mounted) {
      setState(() {
        _isSavingNote = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note saved!'),
          backgroundColor: Color(0xFF3478F6),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1419),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isFuture ? 'Future Hexagram' : 'Primary Hexagram',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _hexagramMeta == null
          ? HexagramNotFoundView(hexagramNumber: widget.hexagramNumber)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HexagramDetailHeader(
                    meta: _hexagramMeta!,
                    themeColor: widget.isFuture
                        ? const Color(0xFF3478F6)
                        : const Color(0xFFFF9500),
                  ),
                  const SizedBox(height: 32.0),
                  HexagramDetailSection(
                    title: 'The Judgment',
                    content: _hexagramMeta!.judgment,
                    themeColor: widget.isFuture
                        ? const Color(0xFF3478F6)
                        : const Color(0xFFFF9500),
                  ),
                  const SizedBox(height: 24.0),
                  HexagramDetailSection(
                    title: 'The Image',
                    content: _hexagramMeta!.image,
                    themeColor: widget.isFuture
                        ? const Color(0xFF3478F6)
                        : const Color(0xFFFF9500),
                  ),
                  const SizedBox(height: 24.0),
                  HexagramLinesSection(
                    meta: _hexagramMeta!,
                    changingLinePositions: widget.changingLinePositions,
                    themeColor: widget.isFuture
                        ? const Color(0xFF3478F6)
                        : const Color(0xFFFF9500),
                  ),
                  const SizedBox(height: 32.0),
                  HexagramNotesSection(
                    controller: _noteController,
                    isSaving: _isSavingNote,
                    onSave: _saveNote,
                    onDelete: () {
                      _noteController.clear();
                      _saveNote();
                    },
                    themeColor: widget.isFuture
                        ? const Color(0xFF3478F6)
                        : const Color(0xFFFF9500),
                  ),
                  const SizedBox(height: 48.0),
                ],
              ),
            ),
    );
  }
}
