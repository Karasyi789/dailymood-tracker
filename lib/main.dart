import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/homepage.dart';
import 'pages/historypage.dart';
import 'pages/grafik.dart';

void main() {
  runApp(DailyMoodApp());
}

class DailyMoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Mood Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 150, 240, 231),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color.fromARGB(255, 164, 213, 213),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
        '/chart': (context) => ChartPage(),
      },
    );
  }
}
