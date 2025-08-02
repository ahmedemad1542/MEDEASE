class DoctorsModel {
  final String id;
  final String name;
  final String gender;
  final String phone;
  final String city;
  final String country;
  final String specialization;
  final String imgUrl;
  final double rate;
  final String url;
  final int totalPages;
  final int currentPage;

  DoctorsModel({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.gender,
    required this.phone,
    required this.specialization,
    required this.imgUrl,
    required this.rate,
    required this.url,
    required this.totalPages,
    required this.currentPage,
  });
  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      specialization: json['specialization'] ?? '',
      imgUrl: json['ImgUrl'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      url: json['Url'] ?? '',
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
    );
  }
}
