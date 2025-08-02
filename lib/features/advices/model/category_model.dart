class CategoryModel {
  final String categoryId;
  final String name;

  CategoryModel({required this.categoryId, required this.name});

  // A factory constructor to create a Category from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['_id'] as String,
      name: json['name'] as String,
    );
  }
}
