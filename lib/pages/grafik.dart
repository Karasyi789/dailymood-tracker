import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  Map<String, int> moodCount = {};

  @override
  void initState() {
    super.initState();
    _loadMoodData();
  }

  void _loadMoodData() async {
    final prefs = await SharedPreferences.getInstance();
    final moodList = prefs.getStringList('moodList') ?? [];

    final counts = <String, int>{};
    for (var entry in moodList) {
      final parts = entry.split('|');
      if (parts.length > 1) {
        final mood = parts[1];
        counts[mood] = (counts[mood] ?? 0) + 1;
      }
    }

    setState(() {
      moodCount = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final moods = moodCount.keys.toList();
    final values = moodCount.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('Grafik Mood')),
      body:
          moodCount.isEmpty
              ? Center(child: Text('Belum ada data untuk ditampilkan.'))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistik Mood Kamu',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY:
                                  (values.reduce(
                                    (a, b) => a > b ? a : b,
                                  )).toDouble() +
                                  1,
                              barGroups: List.generate(
                                moods.length,
                                (i) => BarChartGroupData(
                                  x: i,
                                  barRods: [
                                    BarChartRodData(
                                      toY: values[i].toDouble(),
                                      color: Colors.teal,
                                      width: 20,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ],
                                ),
                              ),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, _) {
                                      if (value.toInt() < moods.length) {
                                        return Text(
                                          moods[value.toInt()],
                                          style: TextStyle(fontSize: 10),
                                        );
                                      }
                                      return Text('');
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
