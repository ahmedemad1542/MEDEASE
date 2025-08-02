class RegisterResponseModel {
  final String name;
  final String email;
  final String password;
  final String phone;
  // final String dateOfBirth;
  final String country;
  final String city;

  RegisterResponseModel({
    // required this.dateOfBirth,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.country,
    required this.city,
  });
}
