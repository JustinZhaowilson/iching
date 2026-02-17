import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class HomeMenuButton extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomeMenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;

  final IconData icon;

  final String route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1C2630),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24.0, color: const Color(0xFF3478F6)),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
