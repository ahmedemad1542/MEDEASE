class AdvertisementsModel {
  String id;
  String title;
  String description;
  String imgUrl;
  String imgPublicId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String creatorName;

  AdvertisementsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.imgPublicId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.creatorName,
  });

  factory AdvertisementsModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementsModel(
        id: json["_id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        imgUrl: json["ImgUrl"] ?? "",
        imgPublicId: json["ImgPublicId"] ?? "",
        createdAt: DateTime.parse(json["createdAt"] ?? ""),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
        v: json["__v"] ?? 0,
        creatorName: json["creatorName"] ?? "",
      );
}
