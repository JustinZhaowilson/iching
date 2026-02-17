import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HexagramNotFoundView extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HexagramNotFoundView({super.key, required this.hexagramNumber});

  final int hexagramNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber, color: Color(0xFF8E9BAE), size: 64.0),
          const SizedBox(height: 16.0),
          Text(
            'Hexagram $hexagramNumber not found',
            style: const TextStyle(color: Color(0xFF8E9BAE), fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Data for this hexagram has not been loaded yet.',
            style: TextStyle(color: Color(0xFF8E9BAE), fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
