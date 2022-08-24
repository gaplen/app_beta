

import 'dart:convert';

import 'package:app_beta/src/api/environment.dart';
import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SearchService{

  String _url = Environment.API_APP;
  String _api = '/api/products';
  BuildContext context;
  User sessionUser;

  // ignore: missing_return
  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }
   Future<List<Product>> findByProductName(String productName) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategory/$productName');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Product product = Product.fromJsonList(data);
      print(res.body);
      return product.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
}
}