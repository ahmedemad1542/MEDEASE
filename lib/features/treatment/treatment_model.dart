class TreatmentModel {
  final String id;
  final String name;
  final String description;
  final String dosage;
  final String instructions;
  final String quantity;
  final int refills;
  final String notes;

  TreatmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.dosage,
    required this.instructions,
    required this.quantity,
    required this.refills,
    required this.notes,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      dosage: json['dosage'],
      instructions: json['instructions'],
      quantity: json['quantity'],
      refills: json['refills'],
      notes: json['notes'],
    );
  }
}
