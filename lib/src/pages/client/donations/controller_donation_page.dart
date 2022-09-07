import 'dart:async';
import 'package:app_beta/src/models/category.dart';
import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:app_beta/src/provider/categories_provider.dart';
import 'package:app_beta/src/provider/donations_provider.dart';
import 'package:app_beta/src/provider/push_notifications_provider.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientDonationsController {

  BuildContext context;
  Function refresh;
  Donations donations;
  Category category;
  int counter = 1;
  SharedPref _sharedPref = new SharedPref();
  List<Donations> selectedProducts = [];
  
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  User user;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  DonationsProvider _donationsProvider = new DonationsProvider();
  List<Category> categories = [];
  Timer searchOnStoppedTyping;
  String productName = '';
  PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();

  


  Future init(BuildContext context, Function refresh, Donations donations) async {
    this.context = context;
    this.refresh = refresh;
    this.donations = donations;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _donationsProvider.init(context, user, donations);
    selectedProducts = Donations.fromJsonList(await _sharedPref.read('order')).toList;
    getCategories();
    getCategories();
    refresh();
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds:500); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
      refresh();
    }

    searchOnStoppedTyping = new Timer(duration, () {
      productName = text;
      refresh();
      // getProducts(idCategory, text)
      print('TEXTO COMPLETO $text');
    });
  }


  Future<List<Donations>> getProducts(String idCategory, String productName) async {
    if (productName.isEmpty) {
      return await _donationsProvider.getByCategory(idCategory);
    }
    else {
      return await _donationsProvider.getByCategoryAndProductName(idCategory, productName);
    }
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product)
    ); 
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == donations.id);

    if (index == -1) { // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (donations.quantity == null) {
        donations.quantity = 1;
      }

      selectedProducts.add(donations);
    }
    else {
      selectedProducts[index].quantity = counter;
    }

    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Producto agregado');
  }
 
  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update'); 
  }

  void goToFavoritePage() {
    Navigator.pushNamed(context, 'client/products/favorite');
  }

  void goToOrdersList() {
    Navigator.pushNamed(context, 'client/orders/list');
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void goToFavoritePets() {
    Navigator.pushNamed(context, 'client/products/favorite'); 
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToGivePet() {
    Navigator.pushNamed(context, 'client/adoptpets');
  }


void goToDonationPage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

void btnDonation(){
  myshowAlertDialog(context);
  
}

void okBtn(){
  myshowAlertDialog(context);
  Navigator.pop(context);
  
}



myshowAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Container(
      // color: Colors.purple,
      child: Column(
        children: [
          Text("OK"),
        ],
      ),
    ),
    onPressed: () {
      // Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      height: 200,
      width: 200,
      // color: Colors.green,
      child: Column(
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: Colors.purple),
            ),
          )
        ],
      ),
    ),
    content: Container(
      height: 50,
      // color: Colors.red,
      child: Column(
        children: [
         
        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}





}