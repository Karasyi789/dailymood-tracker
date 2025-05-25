import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utills/date.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  Map<String, int> moodCounts = {
    'Senang': 0,
    'Sedih': 0,
    'Stres': 0,
    'Biasa Saja': 0,
  };

  @override
  void initState() {
    super.initState();
    _loadMoodData();
  }

  Future<void> _loadMoodData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> moodList = prefs.getStringList('moodList') ?? [];

    final last7Days = DateTime.now().subtract(Duration(days: 7));

    for (String item in moodList) {
      final parts = item.split('|');
      final date = DateTime.parse(parts[0]);
      final mood = parts[1];

      if (date.isAfter(last7Days)) {
        moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
      }
    }

    setState(() {});
  }

  List<PieChartSectionData> getSections() {
    final total = moodCounts.values.reduce((a, b) => a + b);

    return moodCounts.entries.map((entry) {
      final percentage = total == 0 ? 0.0 : (entry.value / total) * 100;
      return PieChartSectionData(
        color: _getMoodColor(entry.key),
        value: percentage,
        title: '${entry.key}\n${entry.value}',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 12),
      );
    }).toList();
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Senang':
        return Colors.green;
      case 'Sedih':
        return Colors.blue;
      case 'Stres':
        return Colors.red;
      case 'Biasa Saja':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grafik Mood (7 Hari)')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child:
              moodCounts.values.every((v) => v == 0)
                  ? Text('Belum ada data mood dalam 7 hari terakhir.')
                  : PieChart(
                    PieChartData(
                      sections: getSections(),
                      centerSpaceRadius: 40,
                    ),
                  ),
        ),
      ),
    );
  }
}
