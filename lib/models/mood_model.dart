class MoodEntry {
  final DateTime date;
  final String mood;

  MoodEntry({required this.date, required this.mood});

  factory MoodEntry.fromString(String data) {
    final parts = data.split('|');
    return MoodEntry(date: DateTime.parse(parts[0]), mood: parts[1]);
  }

  String toStorageString() {
    return '${date.toIso8601String()}|$mood';
  }
}
