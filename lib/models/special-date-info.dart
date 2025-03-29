class SpecialDateInfo {
  final int year;
  final int month;
  final int day;
  final String name;
  final String description;

  SpecialDateInfo({
    required this.year,
    required this.month,
    required this.day,
    required this.name,
    required this.description,
  });

  factory SpecialDateInfo.fromJson(Map<String, dynamic> json) {
    return SpecialDateInfo(
      year: json['year'],
      month: json['month'],
      day: json['day'],
      name: json['name'],
      description: json['description'],
    );
  }
}