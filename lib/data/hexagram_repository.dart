import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:iching/models/hexagram_meta.dart';

/// Repository for accessing hexagram metadata.
/// 
/// Loads hexagram data from JSON assets and provides lookup by number.
class HexagramRepository {
  final Map<int, HexagramMeta> _byNumber = {};
  bool _initialized = false;
  
  /// Singleton instance
  static final HexagramRepository _instance = HexagramRepository._internal();
  
  factory HexagramRepository() => _instance;
  
  HexagramRepository._internal();
  
  /// Initialize the repository by loading JSON data.
  /// Safe to call multiple times; subsequent calls are no-ops.
  Future<void> initialize() async {
    if (_initialized) return;
    
    final jsonString = await rootBundle.loadString('assets/hexagram_data.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final hexagrams = jsonData['hexagrams'] as List<dynamic>;
    
    for (final hex in hexagrams) {
      final meta = HexagramMeta.fromJson(hex as Map<String, dynamic>);
      _byNumber[meta.number] = meta;
    }
    
    _initialized = true;
  }
  
  /// Whether the repository has been initialized.
  bool get isInitialized => _initialized;
  
  /// Get hexagram metadata by number (1-64).
  /// Returns null if the hexagram is not found or not yet loaded.
  HexagramMeta? getByNumber(int number) => _byNumber[number];
  
  /// Get all loaded hexagrams.
  List<HexagramMeta> getAll() => List.unmodifiable(_byNumber.values.toList());
  
  /// Check if a particular hexagram number is available.
  bool hasHexagram(int number) => _byNumber.containsKey(number);
}
