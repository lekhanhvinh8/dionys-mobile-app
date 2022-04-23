import 'dart:convert';

class Category {
  final int id;
  final String name;
  String description;
  final bool status;
  final bool isDisabled;
  int fatherId;
  String imageUrl;
  List<Category> children;

  Category({
    required this.id,
    required this.name,
    required this.status,
    required this.isDisabled,
    this.fatherId = 0,
    this.description = "",
    this.imageUrl = "",
    this.children = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        isDisabled: json['isDisabled'],
        fatherId: json['fatherId'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        children: Category.fromListJson(json['children']));
  }

  static List<Category> fromListJson(List<dynamic> categories) {
    List<Category> categoryList = [];
    for (var categoryJson in categories) {
      var category = Category.fromJson(categoryJson);
      categoryList.add(category);
    }

    return categoryList;
  }
}
