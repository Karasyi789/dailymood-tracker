import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedMood;

  final List<Map<String, dynamic>> moods = [
    {
      'label': 'Sangat Baik',
      'icon': Icons.sentiment_very_satisfied,
      'color': Colors.green[300],
    },
    {
      'label': 'Baik',
      'icon': Icons.sentiment_satisfied,
      'color': Colors.lightGreen[200],
    },
    {
      'label': 'Netral',
      'icon': Icons.sentiment_neutral,
      'color': Colors.grey[400],
    },
    {
      'label': 'Kurang Baik',
      'icon': Icons.sentiment_dissatisfied,
      'color': Colors.orange[300],
    },
    {
      'label': 'Buruk',
      'icon': Icons.sentiment_very_dissatisfied,
      'color': Colors.red[300],
    },
  ];

  void _saveMood() async {
    if (_selectedMood == null) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> moodList = prefs.getStringList('moodList') ?? [];

    moodList.add('${DateTime.now().toIso8601String()}|$_selectedMood');
    await prefs.setStringList('moodList', moodList);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Mood tersimpan.')));

    setState(() {
      _selectedMood = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Mood Harian'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bagaimana perasaanmu hari ini?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...moods.map((mood) {
              final isSelected = _selectedMood == mood['label'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMood = mood['label'];
                  });
                },
                child: Card(
                  color: isSelected ? mood['color'] : Colors.white,
                  elevation: isSelected ? 4 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color:
                          isSelected
                              ? Colors.teal.shade700
                              : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      mood['icon'],
                      size: 28,
                      color: Colors.grey[800],
                    ),
                    title: Text(
                      mood['label'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveMood,
                    icon: Icon(Icons.save),
                    label: Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    icon: Icon(Icons.history),
                    label: Text('Riwayat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/chart'),
                    icon: Icon(Icons.bar_chart),
                    label: Text('Grafik'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
