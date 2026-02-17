import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:iching/components/home_menu_button.dart';

@NowaGenerated()
class HomePage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0F1419), Color(0xFF1A2128)],
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.sizeOf(context).height -
                    MediaQuery.paddingOf(context).vertical,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.auto_awesome_mosaic,
                    color: Color(0xFF3478F6),
                    size: 80.0,
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'I Ching Reading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Unlock ancient wisdom and find guidance',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF8E9BAE), fontSize: 16.0),
                  ),
                  const SizedBox(height: 64.0),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, 'ReadingProcessScreen'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3478F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48.0,
                        vertical: 18.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 8.0,
                      shadowColor: const Color(
                        0xFF3478F6,
                      ).withValues(alpha: 0.4),
                    ),
                    child: const Text(
                      'Cast Reading',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HomeMenuButton(
                        label: 'Journal',
                        icon: Icons.history_edu,
                        route: 'JournalScreen',
                      ),
                      SizedBox(width: 16.0),
                      HomeMenuButton(
                        label: 'Insights',
                        icon: Icons.insights,
                        route: 'StatsScreen',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
