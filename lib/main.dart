import 'package:shared_preferences/shared_preferences.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iching/globals/app_state.dart';
import 'package:iching/pages/home_page.dart';
import 'package:iching/pages/reading_process_screen.dart';
import 'package:iching/pages/reading_result_screen.dart';
import 'package:iching/pages/journal_screen.dart';
import 'package:iching/pages/stats_screen.dart';
import 'package:iching/pages/hexagram_detail_screen.dart';

@NowaGenerated()
late final SharedPreferences sharedPrefs;

@NowaGenerated()
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

@NowaGenerated({'visibleInNowa': false})
class MyApp extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'I Ching',
        theme: AppState.of(context).theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          'ReadingProcessScreen': (context) => const ReadingProcessScreen(),
          'ReadingResultScreen': (context) => const ReadingResultScreen(),
          'JournalScreen': (context) => const JournalScreen(),
          'StatsScreen': (context) => const StatsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == 'HexagramDetailScreen') {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => HexagramDetailScreen(
                hexagramNumber: args?['hexagramNumber'] ?? 1,
                changingLinePositions:
                    args?['changingLinePositions'] as List<int>?,
                isFuture: args?['isFuture'] ?? false,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
