import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3478F6),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

@NowaGenerated()
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3478F6),
    secondary: Color(0xFFFF9500),
    surface: Color(0xFF1C2630),
    surfaceContainerHighest: Color(0xFF0F1419), // Use surfaceContainerHighest instead of surfaceVariant
  ),
  scaffoldBackgroundColor: const Color(0xFF0F1419),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0F1419),
    elevation: 0,
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFF8E9BAE), fontSize: 14),
  ),
  useMaterial3: true,
);
