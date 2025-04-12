class AnnualSummaryModel {
  final String title;
  final String content;

  AnnualSummaryModel({
    required this.title,
    required this.content,
  });

  factory AnnualSummaryModel.fromJson(Map<String, dynamic> json) {
    return AnnualSummaryModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}