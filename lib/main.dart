import 'package:flutter/material.dart';
import 'homepage.dart';
import 'historypage.dart';

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
      },
    );
  }
}
