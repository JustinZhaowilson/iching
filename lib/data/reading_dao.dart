import 'package:sqflite/sqflite.dart';
import 'package:iching/data/database_helper.dart';
import 'package:iching/models/reading.dart';

class ReadingDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertReading(Reading reading) async {
    final db = await _dbHelper.database;
    return await db.insert('readings', reading.toMap());
  }

  Future<List<Reading>> getAllReadings() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'readings', 
      orderBy: 'created_at DESC'
    );
    return maps.map((map) => Reading.fromMap(map)).toList();
  }

  Future<List<Reading>> getFavorites() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'readings',
      where: 'is_favorite = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => Reading.fromMap(map)).toList();
  }

  Future<void> toggleFavorite(int id, bool isFavorite) async {
    final db = await _dbHelper.database;
    await db.update(
      'readings',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteReading(int id) async {
    final db = await _dbHelper.database;
    await db.delete('readings', where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>> getStats() async {
    final db = await _dbHelper.database;
    
    final totalReadings = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM readings')
    ) ?? 0;
    
    final mostCommonHex = await db.rawQuery('''
      SELECT primary_hex, COUNT(primary_hex) as count 
      FROM readings 
      GROUP BY primary_hex 
      ORDER BY count DESC 
      LIMIT 1
    ''');

    final favoritesCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM readings WHERE is_favorite = 1')
    ) ?? 0;

    return {
      'total': totalReadings,
      'most_common_hex': mostCommonHex.isNotEmpty ? mostCommonHex.first['primary_hex'] : null,
      'favorites': favoritesCount,
    };
  }
}
