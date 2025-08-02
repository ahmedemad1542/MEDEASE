class ConversationModel {
  final String id;
  final List<String> members;
  final UserModel otherUser; // Add this line

  ConversationModel({
    required this.id,
    required this.members,
    required this.otherUser, // Add this to the constructor
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      members: List<String>.from(json['members']),
      // Tell the factory how to parse the nested 'otherUser' object
      otherUser: UserModel.fromJson(json['otherUser']),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String role;
  final String imgUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      role: json['role'],
      imgUrl: json['ImgUrl'],
    );
  }
}
