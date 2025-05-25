import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedMood;

  List<String> moods = ['Senang', 'Sedih', 'Stres', 'Biasa Saja'];

  void _saveMood() async {
    if (_selectedMood == null) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> moodList = prefs.getStringList('moodList') ?? [];

    moodList.add('${DateTime.now().toIso8601String()}|$_selectedMood');

    await prefs.setStringList('moodList', moodList);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Mood berhasil disimpan!')));

    setState(() {
      _selectedMood = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daily Mood Tracker')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Pilih mood hari ini'),
              value: _selectedMood,
              items:
                  moods
                      .map((m) => DropdownMenuItem(child: Text(m), value: m))
                      .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedMood = val;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveMood, child: Text('Simpan Mood')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
              child: Text('Lihat Riwayat Mood'),
            ),
          ],
        ),
      ),
    );
  }
}
