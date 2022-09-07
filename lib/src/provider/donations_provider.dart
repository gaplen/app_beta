import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:app_beta/src/api/environment.dart';
import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DonationsProvider {

  String _url = Environment.API_APP;
  String _api = '/api/donations';
  BuildContext context;
  User sessionUser;
  Donations donations;

  // ignore: missing_return
  Future init(BuildContext context, User sessionUser, Donations donations) {
    this.context = context;
    this.sessionUser = sessionUser;
    this.donations = donations;
  }

  Future<List<Donations>> findByProductName(String productName) async {
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
      Donations donations = Donations.fromJsonList(data);
      return donations.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

   Future<List<Donations>> favorite(String isFavorite) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategory/$isFavorite');
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
      Donations donations = Donations.fromJsonList(data);
      return donations.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }


  Future<List<Donations>> getByCategory(String idCategory) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
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
      Donations donations = Donations.fromJsonList(data);
      return donations.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Donations>> 
  getByCategoryAndProductName(String idCategory, String productName) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategoryAndProductName/$idCategory/$productName');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);
      print(res);
  
      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.id);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Donations donations = Donations.fromJsonList(data);
      return donations.toList;

  

    }

    catch(e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Stream> create(Donations donations, List<File> images) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser.sessionToken;

      for (int i = 0; i < images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));
      }

      request.fields['donations'] = json.encode(donations);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }



   Future<List<Donations>> getAll() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
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
      Donations category = Donations.fromJsonList(data);
      return category.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];
    }
  }

}