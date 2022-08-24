import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}



class MenuItem {
  String title;
  IconData icon;
  MenuItem(this.icon, this.title);
}

final List<MenuItem> options = [
  MenuItem(Icons.payment, 'Payments'),
  MenuItem(Icons.favorite, 'Discounts'),
  MenuItem(Icons.notifications, 'Notification'),
  MenuItem(Icons.format_list_bulleted, 'Orders'),
  MenuItem(Icons.help, 'Help'),
];