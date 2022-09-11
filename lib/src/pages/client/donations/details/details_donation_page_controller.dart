import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientDonationsDetailController {
  BuildContext context;

  Function refresh;
  Donations donations;

  int counter = 1;
  double productPrice;

  SharedPref _sharedPref = new SharedPref();

  List<Donations> selectedProducts = [];

  Future init(
    BuildContext context,
    Function refresh,
    Donations donations,
  ) async {
    this.context = context;
    this.refresh = refresh;
    this.donations = donations;
    productPrice = donations.price;
        selectedProducts = Donations.fromJsonList(await _sharedPref.read('order')).toList;


    selectedProducts.forEach((p) {
      print('Producto seleccionado: ${p.toJson()}');
    });

    refresh();
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == donations.id);

    if (index == -1) {
      // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (donations.quantity == null) {
        donations.quantity = 1;
      }

      selectedProducts.add(donations);
    } else {
      selectedProducts[index].quantity = counter;
    }

    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Producto agregado');
  }

  void addItem() {
    counter = counter + 1;
    productPrice = donations.price * counter;
    donations.quantity = counter;
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
      productPrice = donations.price * counter;
      donations.quantity = counter;
      refresh();
    }
  }

  void goToAddress() {
    Navigator.pushNamed(context, 'client/address/list');
  }

  void close() {
    Navigator.pop(context);
  }
}
