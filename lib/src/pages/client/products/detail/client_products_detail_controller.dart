


import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController {
  BuildContext context;

  Function refresh;
  Product product;

  int counter = 1;
  double productPrice;
  

  SharedPref _sharedPref = new SharedPref();

  List<Product> selectedProducts = [];


  Future init(BuildContext context,Function refresh,Product product,
    
  ) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;

    selectedProducts.forEach((p) {
      print('Producto seleccionado: ${p.toJson()}');
    });

    refresh();

  }

  


  void addFavorite() {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (product.quantity == null) {
        product.quantity = 1;
      }
      selectedProducts.add(product);

    } else {
      selectedProducts[index].quantity = counter;
      if (counter > 1) {
      counter = counter - 1;
      productPrice = product.price * counter;
      product.quantity = counter;
      refresh();
    }
      
    }
    // removeItem();
    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Agregado a favoritos');
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (product.quantity == null) {
        product.quantity = 1;
      }

      selectedProducts.add(product);
    } else {
      

      // selectedProducts[index].quantity = counter;
    }

    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Agregado a favoritos');
  }

  void addItem() {
    counter = counter + 1;
    productPrice = product.price * counter;
    product.quantity = counter;
    refresh();
  }

  void goToNewAddress() async {
    var result = await Navigator.pushNamed(context, 'client/address/create');

    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

  void removeItem() {
    if (counter >= 1) {
      counter = counter - 1;
      productPrice = product.price * counter;
      product.quantity = counter;
      refresh();  
    }
  }



   void goToQuestion() async {
    var result = await Navigator.pushNamed(context, 'client/questions/create');

    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }


   void goToAddress() {
    Navigator.pushNamed(context, 'client/address/list');
  }

  void close() {
    Navigator.pop(context);
  }
}
