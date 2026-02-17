import 'package:sqflite/sqflite.dart';
import 'package:iching/data/database_helper.dart';
import 'package:iching/models/note.dart';

class NoteDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> upsertNote(Note note) async {
    final db = await _dbHelper.database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Note?> getNoteForHexagram(int hexagramNum) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'hexagram_num = ?',
      whereArgs: [hexagramNum],
    );

    if (maps.isEmpty) return null;
    return Note.fromMap(maps.first);
  }

  Future<void> deleteNote(int hexagramNum) async {
    final db = await _dbHelper.database;
    await db.delete(
      'notes',
      where: 'hexagram_num = ?',
      whereArgs: [hexagramNum],
    );
  }
}
