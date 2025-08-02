class MessageModel {
  final String id;
  final String sender;
  final String text;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.sender,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      sender: json['sender'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}