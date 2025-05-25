import 'package:flutter/material.dart';
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
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
        '/chart': (context) => ChartPage(),
      },
    );
  }
}
