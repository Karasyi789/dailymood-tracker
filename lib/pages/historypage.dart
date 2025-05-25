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
    final data = prefs.getStringList('moodList') ?? [];
    print('Data mood: $data');
    setState(() {
      moodList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Mood'), centerTitle: true),
      body:
          moodList.isEmpty
              ? Center(child: Text('Belum ada data mood.'))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        moodList.map((item) {
                          final split = item.split('|');
                          final date = DateTime.tryParse(split[0]);
                          final mood =
                              split.length > 1 ? split[1] : 'Tidak diketahui';
                          return Chip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mood,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                      255,
                                      30,
                                      29,
                                      29,
                                    ),
                                  ),
                                ),
                                if (date != null)
                                  Text(
                                    '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color.fromARGB(
                                        179,
                                        27,
                                        26,
                                        26,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            backgroundColor: const Color.fromARGB(
                              255,
                              234,
                              238,
                              237,
                            ),
                            padding: EdgeInsets.all(8),
                          );
                        }).toList(),
                  ),
                ),
              ),
    );
  }
}
