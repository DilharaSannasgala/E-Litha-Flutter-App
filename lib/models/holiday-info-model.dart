class HolidayInfo {
  final int year;
  final int month;
  final int day;
  final String name;
  final String description;

  HolidayInfo({
    required this.year,
    required this.month,
    required this.day,
    required this.name,
    required this.description,
  });

  factory HolidayInfo.fromJson(Map<String, dynamic> json) {
    return HolidayInfo(
      year: json['year'],
      month: json['month'],
      day: json['day'],
      name: json['name'],
      description: json['description'],
    );
  }
}