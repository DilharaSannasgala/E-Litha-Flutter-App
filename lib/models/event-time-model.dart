class EventTimeInfo {
  final String title;
  final String icon;
  final List<EventDate> dates;

  const EventTimeInfo({
    required this.title,
    required this.icon,
    required this.dates,
  });

  factory EventTimeInfo.fromJson(Map<String, dynamic> json) {
    return EventTimeInfo(
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      dates: (json['dates'] as List?)
              ?.map((item) => EventDate.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class EventDate {
  final int day;
  final int month;
  final String description;

  const EventDate({
    required this.day,
    required this.month,
    required this.description,
  });

  factory EventDate.fromJson(Map<String, dynamic> json) {
    return EventDate(
      day: json['day'] ?? 1,
      month: json['month'] ?? 1,
      description: json['description'] ?? '',
    );
  }
}