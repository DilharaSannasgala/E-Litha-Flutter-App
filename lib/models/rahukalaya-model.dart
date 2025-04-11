class RahuKalayaModel {
  final String day;
  final String startTime;
  final String conjunction;
  final String endTime;
  final String until;

  RahuKalayaModel({
    required this.day,
    required this.startTime,
    required this.conjunction,
    required this.endTime,
    required this.until,
  });

  factory RahuKalayaModel.fromJson(List<dynamic> json) {
    return RahuKalayaModel(
      day: json[0],
      startTime: json[1],
      conjunction: json[2],
      endTime: json[3],
      until: json[4],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'conjunction': conjunction,
      'endTime': endTime,
      'until': until,
    };
  }
}