import 'dart:convert';

GivePet givepetFromJson(String str) => GivePet.fromJson(json.decode(str));

String givepetToJson(GivePet data) => json.encode(data.toJson());
   
class GivePet {
  String id;
  String name;
  String age;
  String sex;
  String weight;
  String breed;
  String description;
  String image1;
  String image2; 
  String image3;
  bool isFavorite = false;
  double price;
  int idCategory;
  int quantity;
  List<GivePet> toList = [];

  GivePet({
    this.id,
    this.name,
    this.age,
    this.sex,
    this.weight,
    this.breed,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.price,
    this.idCategory,
    this.quantity,
  });

  factory GivePet.fromJson(Map<String, dynamic> json) => GivePet(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    age: json["age"],
    sex: json["sex"],
    weight: json["weight"],
    breed: json["breed"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    price: json['price'] is String ? double.parse(json["price"]) : isInteger(json["price"]) ? json["price"].toDouble() : json['price'],
    idCategory: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
    quantity: json["quantity"],
  );

  GivePet.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      GivePet givepet = GivePet.fromJson(item);
      toList.add(givepet);
    });
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "sex": sex,
    "weight": weight,
    "breed": breed,
    "description": description,
    "image1": image1, 
    "image2": image2,
    "image3": image3,
    "price": price,
    "id_category": idCategory,
    "quantity": quantity,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

}
