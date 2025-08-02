class AdviceModel {
  final String id;
  final String doctorId;
  final String title;
  final String description;
  final String diseasesCategoryName;
  final String createdAt;
  final String updatedAt;

  AdviceModel({
    required this.id,
    required this.doctorId,
    required this.title,
    required this.description,
    required this.diseasesCategoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      id: json['_id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      diseasesCategoryName: json['diseasesCategoryName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

