

import 'dart:convert';
import 'dart:io';
import 'package:app_beta/src/models/category.dart';
import 'package:app_beta/src/models/response_api.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/provider/categories_provider.dart';
import 'package:app_beta/src/utils/my_snackbar.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class PetsCategoriesCreateController {
  
  BuildContext context;
  TextEditingController nameController = new TextEditingController();
  TextEditingController sexnameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
    TextEditingController sex2Controller = new TextEditingController();
  
  



  CategoriesProvider categoriesProvider = new CategoriesProvider();

  User user;


  PickedFile pickedFile;
  File imageFile; 
  ProgressDialog _progressDialog;
  Function refresh;


  SharedPref sharedPref = new SharedPref();

  Category category;
  
  bool isEnable = true;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    categoriesProvider.init(context, user,);
    _progressDialog = ProgressDialog(context: context);
    
  }

   void createCategory() async {
    String name = nameController.text;
    String sex = sexnameController.text;
    String sex2 = sex2Controller.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    
    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;


    Category category = new Category(
      name: name,
      sex:  sex,
      sex2: sex2,
      description: description
    );

    Stream stream = await categoriesProvider.createWithImage(category, imageFile);
    stream.listen((res) { 
      _progressDialog.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('respuesta: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

       if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
          // Navigator.pushReplacementNamed(context, 'login');
        });
      }
      else {
        isEnable = true;
      }
    });

   

    // ResponseApi responseApi = await categoriesProvider.create(category);

    // MySnackbar.show(context, responseApi.message);

    // if (responseApi.success) {
    //   nameController.text = '';
    //   descriptionController.text = '';
    // }

    // Navigator.pop(context);

  }


 Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }





  void createWithImage() async {
    String name = nameController.text;
    String description = descriptionController.text;



    if ( name.isEmpty || description. isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

     if (imageFile == null) {
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }


    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;

    Category category = new Category(
      name: name,
      description: description,
    );

    Stream stream = await categoriesProvider.createWithImage(category, imageFile);
    stream.listen((res) {

      _progressDialog.close();

      // ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('RESPUESTA: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
          // Navigator.pushReplacementNamed(context, 'login');
        });
      }
      else {
        isEnable = true;
      }
    });
  }


   void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
    );
  }


  
  
 

  
}