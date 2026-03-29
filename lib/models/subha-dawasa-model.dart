class SubhaDawasaMonth {
  final int id;
  final String monthName;
  final List<SubhaDawasaDay> days;

  SubhaDawasaMonth({
    required this.id,
    required this.monthName,
    required this.days,
  });

  factory SubhaDawasaMonth.fromJson(Map<String, dynamic> json) {
    return SubhaDawasaMonth(
      id: json['id'],
      monthName: json['monthName'],
      days: (json['days'] as List)
          .map((dayJson) => SubhaDawasaDay.fromJson(dayJson))
          .toList(),
    );
  }
}

class SubhaDawasaDay {
  final String day;
  final String time;
  final String timeOriginal;

  SubhaDawasaDay({
    required this.day,
    required this.time,
    required this.timeOriginal,
  });

  factory SubhaDawasaDay.fromJson(Map<String, dynamic> json) {
    return SubhaDawasaDay(
      day: json['day'],
      time: json['time'],
      timeOriginal: json['timeOriginal'],
    );
  }
}