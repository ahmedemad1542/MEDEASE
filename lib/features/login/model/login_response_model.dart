class LoginResponseModel {
  final String? accessToken;
  final String? role;
  final String? refreshToken;
  final String? userId;

  LoginResponseModel({
    required this.role,
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'],
      role: json['Role'],
      refreshToken: json['refreshToken'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'Role': role,
      'refreshToken': refreshToken,
      'userId': userId,
    };
  }
}
