class MoonPhaseInfo {
  final int year;
  final int month;
  final int day;
  final String phase;
  final String name;

  MoonPhaseInfo({
    required this.year,
    required this.month,
    required this.day,
    required this.phase,
    required this.name,
  });

  factory MoonPhaseInfo.fromJson(Map<String, dynamic> json) {
    return MoonPhaseInfo(
      year: json['year'],
      month: json['month'],
      day: json['day'],
      phase: json['phase'].toString().toLowerCase(),
      name: json['name'],
    );
  }
}