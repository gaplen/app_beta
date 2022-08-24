import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.idUser,
    this.address,
    this.neighborhood,
    this.postalCode,
    this.telephono,
    this.lat,
    this.lng,
  });

  String id;
  String idUser;
  String address;
  String neighborhood;
  String postalCode;
  String telephono;
  double lat;
  double lng;
  List<Address> toList = [];

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] is int ? json['id'].toString() : json['id'],
    idUser: json["id_user"],
    address: json["address"],
    neighborhood: json["neighborhood"],
    postalCode: json["postalCode"],
    telephono: json["telephono"],
    lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
    lng: json["lng"] is String ? double.parse(json["lng"]) : json["lng"],
  );

  Address.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Address address = Address.fromJson(item);
      toList.add(address);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "address": address,
    "neighborhood": neighborhood,
    "postalCode": postalCode,
    "telephono": telephono,
    "lat": lat,
    "lng": lng,
  };
}
