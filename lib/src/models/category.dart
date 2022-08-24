import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {

  String id;
  String name;
  String image;
  String description;
  List<Category> toList = [];

  Category({
    this.id,
    this.name,
    this.image,
    this.description,
  });



  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    image: json["image"],
    description: json["description"],
  );

  Category.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Category category = Category.fromJson(item);
      toList.add(category);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
  };
}
