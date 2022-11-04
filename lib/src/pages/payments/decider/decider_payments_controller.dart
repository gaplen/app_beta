import 'package:app_beta/src/models/order.dart';
import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/pages/payments/contraentrega/contraentrega_payment_page.dart';
import 'package:app_beta/src/provider/orders_provider.dart';
import 'package:app_beta/src/provider/push_notifications_provider.dart';
import 'package:app_beta/src/provider/users_provider.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DeciderController {

  BuildContext context;
  Function refresh;

  Product product;

  int counter = 1;
  double productPrice;
  bool isUpdated;

  SharedPref _sharedPref = new SharedPref();

  double total = 0;
  Order order;
  List<String> status = [''];
  User user;
  List<User> users = [];
  UsersProvider _usersProvider = new UsersProvider();
  OrdersProvider _ordersProvider = new OrdersProvider();
  PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();
  String idDelivery;

  

  Future init(BuildContext context, Function refresh, Order order) async {
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    user = User.fromJson(await _sharedPref.read('user'));
    _usersProvider.init(context, sessionUser: user);
    _ordersProvider.init(context, user);


    refresh();
  }

  Future<List<Order>> getOrders(String status) async {
    return await _ordersProvider.getByClientAndStatus(user.id, status);
  }

  void openBottomSheet(Order order) async {
        await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ContraEntregaPage()
    );
    }
  }

  

  




