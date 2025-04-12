class AnnualPredictionModel {
  final String content;

  AnnualPredictionModel({
    required this.content,
  });

  factory AnnualPredictionModel.fromJson(Map<String, dynamic> json) {
    return AnnualPredictionModel(
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
}