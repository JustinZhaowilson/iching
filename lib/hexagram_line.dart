import 'package:iching/line_type.dart';
import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramLine {
  HexagramLine({
    required this.type,
    this.isChanging = false,
    this.changingColor,
  });

  final LineType type;

  final bool isChanging;

  final Color? changingColor;
}
