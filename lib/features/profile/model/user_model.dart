class UserModel {
  final String id;
  final String name;
  final String gender;
  final String email;
  final String password;
  final String phone;
  final String city;
  final String country;
  final String role;
  final String imgUrl;
  final String imgPublicId;
  final bool isVerified;
  final DateTime dateOfBirth;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> allergies;
  final List<String> chronicConditions;
  final List<String> surgeries;
  final List<dynamic> appointments;

  UserModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.password,
    required this.phone,
    required this.city,
    required this.country,
    required this.role,
    required this.imgUrl,
    required this.imgPublicId,
    required this.isVerified,
    required this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
    required this.allergies,
    required this.chronicConditions,
    required this.surgeries,
    required this.appointments,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final medicalHistory = json['data']['medicalHistory'] ?? {};
    return UserModel(
      id: json["data"]['_id'] ?? '',
      name: json["data"]['name'] ?? '',
      gender: json["data"]['gender'] ?? '',
      email: json["data"]['email'] ?? '',
      password: json["data"]['password'] ?? '',
      phone: json["data"]['phone'] ?? '',
      city: json["data"]['city'] ?? '',
      country: json["data"]['country'] ?? '',
      role: json["data"]['role'] ?? '',
      imgUrl: json['data']['ImgUrl'] ?? '',
      imgPublicId: json['data']['ImgPublicId'] ?? '',
      isVerified: json['data']['isVerified'] ?? false,
      dateOfBirth: DateTime.parse(json['data']['dateOfBirth']),
      createdAt: DateTime.parse(json['data']['createdAt']),
      updatedAt: DateTime.parse(json['data']['updatedAt']),
      allergies: List<String>.from(medicalHistory['allergies'] ?? []),
      chronicConditions: List<String>.from(
        medicalHistory['chronicConditions'] ?? [],
      ),
      surgeries: List<String>.from(medicalHistory['surgeries'] ?? []),
      appointments: List<dynamic>.from(json['data']['Appointment'] ?? []),
    );
  }
}
