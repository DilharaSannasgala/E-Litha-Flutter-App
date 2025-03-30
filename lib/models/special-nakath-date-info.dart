class SpecialNakathDateInfo {
  final int year;
  final int month;
  final int day;
  final String time;
  final String name;
  final String description;

  SpecialNakathDateInfo({
    required this.year,
    required this.month,
    required this.day,
    required this.time,
    required this.name,
    required this.description,
  });

  factory SpecialNakathDateInfo.fromJson(Map<String, dynamic> json) {
    return SpecialNakathDateInfo(
      year: json['year'] as int,
      month: json['month'] as int,
      day: json['day'] as int,
      time: json['time'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
    );
  }
}