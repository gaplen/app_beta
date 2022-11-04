import 'dart:convert';

import 'package:app_beta/src/models/address.dart';
import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {

  String id;
  String idClient;
  String idDelivery;
  String idAddress;
  String status;
  double lat;
  double lng;
  int timestamp;
  List<Product> products = [];
  List<Donations> donations = [];
  List<Order> toList = [];
  User client;
  User delivery;
  Address address;

  Order({
    this.id,
    this.idClient,
    this.idDelivery,
    this.idAddress,
    this.status,
    this.lat,
    this.lng,
    this.timestamp,
    this.products,
    this.donations,
    this.client,
    this.delivery,
    this.address
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    idClient: json["id_client"],
    idDelivery: json["id_delivery"],
    idAddress: json["id_address"],
    status: json["status"],
    lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
    lng: json["lng"] is String ? double.parse(json["lng"]) : json["lng"],
    timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]) : json["timestamp"],
    products: json["products"] != null ? List<Product>.from(json["products"].map((model) => model is Product ? model : Product.fromJson(model))) ?? [] : [],
    donations: json["donations"] != null ? List<Donations>.from(json["donations"].map((model) => model is Donations ? model : Donations.fromJson(model))) ?? [] : [],
   
    client: json['client'] is String ? userFromJson(json['client']) : json['client'] is User ? json['client'] : User.fromJson(json['client'] ?? {}),
    delivery: json['delivery'] is String ? userFromJson(json['delivery']) : json['delivery'] is User ? json['delivery'] : User.fromJson(json['delivery'] ?? {}),
    address: json['address'] is String ? addressFromJson(json['address']) : json['address'] is Address ? json['address'] : Address.fromJson(json['address'] ?? {})
  );

  Order.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Order order = Order.fromJson(item);
      toList.add(order);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "id_delivery": idDelivery,
    "id_address": idAddress,
    "status": status,
    "lat": lat,
    "lng": lng,
    "timestamp": timestamp,
    "products": products,
    "donations": donations,
    "client": client,
    "delivery": delivery,
    "address": address,
  };
}
