import 'dart:async';
import 'package:app_beta/src/models/category.dart';
import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:app_beta/src/provider/categories_provider.dart';
import 'package:app_beta/src/provider/products_provider.dart';
import 'package:app_beta/src/provider/push_notifications_provider.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController {

  BuildContext context;
  Function refresh;
  Product product;
  Category category;
  int counter = 1;
  SharedPref _sharedPref = new SharedPref();
  List<Product> selectedProducts = [];
  List<Product> selectedFavorite = [];
  
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  User user;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  PetsProvider _productsProvider = new PetsProvider();
  List<Category> categories = [];
  Timer searchOnStoppedTyping;
  String productName = '';
  PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();

  


  Future init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user, product);
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    getCategories();
    selectedProducts = Product.fromJsonList(await _sharedPref.read('favore')).toList;
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

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    int index = selectedFavorite.indexWhere((p) => p.id == product.id);
     product = this.product;
      product.isFavorite = isLiked;
      _sharedPref.save('favorite', selectedFavorite);
      Fluttertoast.showToast(msg: 'agregado  a favoritos');

      if (index == -1) {
      // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (product.quantity == null) {
        product.quantity = 1;
      }

      selectedFavorite.add(product);
    }
    

    return !isLiked;
  }

  Future<List<Product>> getProducts(String idCategory, String productName) async {
    if (productName.isEmpty) {
      return await _productsProvider.getByCategory(idCategory);
    }
    else {
      return await _productsProvider.getByCategoryAndProductName(idCategory, productName);
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
    int index = selectedProducts.indexWhere((p) => p.id == product.id);

    if (index == -1) { // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (product.quantity == null) {
        product.quantity = 1;
      }

      selectedProducts.add(product);
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




}