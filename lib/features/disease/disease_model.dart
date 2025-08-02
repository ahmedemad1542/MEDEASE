class DiseaseModel {
  final String id;
  final String name;
  final String description;
  final String rank;

  DiseaseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rank,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rank: json['rank'] ?? '',
    );
  }
}
