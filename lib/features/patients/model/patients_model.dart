class PatientModel {
  final String id;
  final String name;
  final String gender;
  final String email;
  final String phone;
  final String city;
  final String country;
  final String imgUrl;
  final String imgPublicId;
  final DateTime dateOfBirth;
  final MedicalHistory medicalHistory;

  PatientModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.phone,
    required this.city,
    required this.country,
    required this.imgUrl,
    required this.imgPublicId,
    required this.dateOfBirth,
    required this.medicalHistory,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['_id'],
      name: json['name'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      city: json['city'],
      country: json['country'],
      imgUrl: json['ImgUrl'],
      imgPublicId: json['ImgPublicId'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      medicalHistory: MedicalHistory.fromJson(json['medicalHistory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'gender': gender,
      'email': email,
      'phone': phone,
      'city': city,
      'country': country,
      'ImgUrl': imgUrl,
      'ImgPublicId': imgPublicId,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'medicalHistory': medicalHistory.toJson(),
    };
  }
}

class MedicalHistory {
  final List<String> allergies;
  final List<String> chronicConditions;
  final List<String> surgeries;

  MedicalHistory({
    required this.allergies,
    required this.chronicConditions,
    required this.surgeries,
  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) {
    return MedicalHistory(
      allergies: List<String>.from(json['allergies']),
      chronicConditions: List<String>.from(json['chronicConditions']),
      surgeries: List<String>.from(json['surgeries']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allergies': allergies,
      'chronicConditions': chronicConditions,
      'surgeries': surgeries,
    };
  }
}
