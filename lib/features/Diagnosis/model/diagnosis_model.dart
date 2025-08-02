class DiagnosisModel {
  final String id;
  final String? title;
  final String? description;
  final List<String>? symptoms;
  final List<String>? medications;
  final String? recommendations;
  final String? followUp;
  final String? notes;
  final String? status;

  DiagnosisModel({
    required this.id,
    required this.title,
    required this.description,
    required this.symptoms,
    required this.medications,
    required this.recommendations,
    required this.followUp,
    required this.notes,
    required this.status,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      // 1. Use '_id' which is a common convention for database IDs.
      // 2. Add '?? ''` to prevent null errors if the ID is missing.
      id: json['_id'] ?? '',

      title: json['name'] ?? '',
      description: json['description'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      medications: List<String>.from(json['treatments'] ?? []),
      recommendations: json['recommendations'] ?? '',
      followUp: json['followUp'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
