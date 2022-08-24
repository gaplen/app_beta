import 'package:flutter/material.dart';


class DialogPage extends StatefulWidget {
  DialogPage({Key key}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child:Container(),),
          Container(),
          Container(child: Text('hola')),
        ],
      ),
    );
  }
}