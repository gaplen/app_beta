import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {

  String id;
  String name;
  String image;
  String image2;
  String image3;
  String sex;
  String sex2;
  String description;
  List<Category> toList = [];

  Category({
    this.id,
    this.name,
    this.image,
    this.image2,
    this.image3,
    this.sex,
    this.sex2,
    this.description,
  });



  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    image: json["image"],
    image2: json["image2"],
    image3: json ["image3"],
    sex: json["sex"],
    sex2: json["sex2"],
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
    "image2": image2,
    "image3": image3,
    "sex" :sex,
    "sex2" :sex2,
    "description": description,
  };
}
