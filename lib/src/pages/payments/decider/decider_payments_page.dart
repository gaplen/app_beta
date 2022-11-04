
import 'package:app_beta/src/models/order.dart';
import 'package:app_beta/src/pages/payments/decider/decider_payments_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:app_beta/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DeciderPaymentPage extends StatefulWidget {
  DeciderPaymentPage({Key key,}) : super(key: key);
  

  @override
  _DeciderPaymentPageState createState() => _DeciderPaymentPageState();
  Order order;
  
}

class _DeciderPaymentPageState extends State<DeciderPaymentPage> {
  DeciderController _con =  DeciderController();
  

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
       _con.init(context, refresh, widget.order);
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text('Método de pago'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textSelectPayments(),
          _btncCard()
        ],
      ),
    );
  }
  Widget btnTransfer(Order order){
    return  GestureDetector(
            onTap: (){
              _con.openBottomSheet(order);
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.yellow.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text('pago contraentrega', style: TextStyle(fontSize: 20),)),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 60,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child: Image.asset('assets/img/contraentrega.png')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
  
  Widget _textSelectPayments() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Elige un método de pago',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _btncCard() {
    return Container(
      child: Column(
        children: [
         GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'client/payments/contraentrega');
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.yellow.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text('pago contraentrega', style: TextStyle(fontSize: 20),)),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 60,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child: Image.asset('assets/img/contraentrega.png')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
         GestureDetector(
           onTap: (){
             Navigator.pushNamed(context, 'client/payments/create');
           },
           child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.yellow.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text('Tarjeta credito/debito', style: TextStyle(fontSize: 20),)),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 60,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child: Image.asset('assets/img/tarjeta-de-credito.png')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
         ),
          GestureDetector(
            onTap: (){
              
               
              
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.yellow.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text('Transferencia Bancaria', style: TextStyle(fontSize: 20),)),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 60,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child: Image.asset('assets/img/bank-transfer.png')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
