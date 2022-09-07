import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientOrdersCreateController {

  BuildContext context;
  Function refresh;

  Donations donations;

  int counter = 1;
  double productPrice;

  SharedPref _sharedPref = new SharedPref();

  List<Donations> selectedProducts = [];
  double total = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    selectedProducts = Donations.fromJsonList(await _sharedPref.read('order')).toList;

    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    selectedProducts.forEach((donations) {
      total = total + (donations.quantity * donations.price);
    });
    refresh();
  }

  void addItem(Donations donations) {
    int index = selectedProducts.indexWhere((p) => p.id == donations.id);
    selectedProducts[index].quantity = selectedProducts[index].quantity + 1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Donations donations) {
    if (donations.quantity > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == donations.id);
      selectedProducts[index].quantity = selectedProducts[index].quantity - 1;
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Donations donations) {
    selectedProducts.removeWhere((p) => p.id == donations.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void goToAddress() {
    Navigator.pushNamed(context, 'client/address/list');
  }

}