import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class NoDataWidget extends StatelessWidget {

  String text;

  NoDataWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width  * 0.50,
        //margin: EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/doog.json'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Text(text, textAlign: TextAlign.center,)
            )
          ],
        ),
      ),
    );
  }


}
