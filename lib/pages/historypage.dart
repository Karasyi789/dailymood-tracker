import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> moodList = [];

  @override
  void initState() {
    super.initState();
    _loadMoodList();
  }

  void _loadMoodList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      moodList = prefs.getStringList('moodList') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Mood')),
      body: ListView.builder(
        itemCount: moodList.length,
        itemBuilder: (context, index) {
          final item = moodList[index].split('|');
          final date = DateTime.parse(item[0]);
          final mood = item[1];
          return ListTile(
            title: Text(mood),
            subtitle: Text(
              '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}',
            ),
          );
        },
      ),
    );
  }
}
