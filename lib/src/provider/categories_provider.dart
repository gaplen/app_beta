import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:app_beta/src/api/environment.dart';
import 'package:app_beta/src/models/category.dart';
import 'package:app_beta/src/models/response_api.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';


class CategoriesProvider {
  String _url = Environment.API_APP;
  String _api = '/api/categories';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Category>> getAll() async {
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
      Category category = Category.fromJsonList(data);
      return category.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }


 Future<ResponseApi> create(Category category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream> createWithImage(Category category, List<File> image) async {
    try {
      Uri url = Uri.http(_url, '$_api/createWithImage');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser.sessionToken;

      for (int i = 0; i < image.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(image[i].openRead().cast()),
            await image[i].length(),
            filename: basename(image[i].path)
        ));
      }

      request.fields['category'] = json.encode(category);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }
  

  //  Future<Stream> create(Category category, List<File> images) async {
  //   try {
  //     Uri url = Uri.http(_url, '$_api/create');
  //     final request = http.MultipartRequest('POST', url);
  //     request.headers['Authorization'] = sessionUser.sessionToken;

  //     for (int i = 0; i < images.length; i++) {
  //       request.files.add(http.MultipartFile(
  //           'image',
  //           http.ByteStream(images[i].openRead().cast()),
  //           await images[i].length(),
  //           filename: basename(images[i].path)
  //       ));
  //     }

  //     request.fields['category'] = json.encode(category);
  //     final response = await request.send(); // ENVIARA LA PETICION
  //     return response.stream.transform(utf8.decoder);
  //   }
  //   catch(e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }



}
