import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:app_beta/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientOrdersCreatePage extends StatefulWidget {
  const ClientOrdersCreatePage({Key key}) : super(key: key);

  @override
  _ClientOrdersCreatePageState createState() => _ClientOrdersCreatePageState();
}

class _ClientOrdersCreatePageState extends State<ClientOrdersCreatePage> {

  ClientOrdersCreateController _con = new ClientOrdersCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi orden'),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.235,
        child: Column(
          children: [
            Divider(
              color: Colors.grey[400],
              endIndent: 30, // DERECHA
              indent: 30, //IZQUIERDA
            ),
            _textTotalPrice(),
            _buttonNext()
          ],
        ),
      ),
      body: _con.selectedProducts.length > 0
      ? ListView(
        children: _con.selectedProducts.map((Donations donations) {
          return _cardProduct(donations);
        }).toList(),
      )
      : NoDataWidget(text: 'Ningun producto agregado',),
    );
  }

 Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.goToAddress,
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'CONTINUAR',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 80, top: 9),
                height: 30,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  
  Widget _cardProduct(Donations donations) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            _imageProduct(donations),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donations?.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                _addOrRemoveItem(donations)
              ],
            ),
            Spacer(),
            Column(
              children: [
                _textPrice(donations),
                _iconDelete(donations)
              ],
            )
          ],
        ),
    );
  }
  
  Widget _iconDelete(Donations donations) {
    return IconButton(
        onPressed: () {
          _con.deleteItem(donations);
        },
        icon: Icon(Icons.delete, color: MyColors.primaryColor,)
    );
  }

  Widget _textTotalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          Text(
            '${_con.total}\$',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          )
        ],
      ),
    );
  }

  Widget _textPrice(Donations donations) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '${donations.price * donations.quantity}',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _imageProduct(Donations donations) {
    return Container(
      width: 90,
      height: 90,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200]
      ),
      child: FadeInImage(
        image: donations.image1 != null
            ? NetworkImage(donations.image1)
            : AssetImage('assets/img/no-image.png'),
        fit: BoxFit.contain,
        fadeInDuration: Duration(milliseconds: 50),
        placeholder: AssetImage('assets/img/no-image.png'),
      ),
    );
  }

  Widget _addOrRemoveItem(Donations donations) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _con.removeItem(donations);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)
                ),
                color: Colors.grey[200]
            ),
            child: Text('-'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${donations?.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () {
            _con.addItem(donations);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)
                ),
                color: Colors.grey[200]
            ),
            child: Text('+'),
          ),
        ),
      ],
    );
  }
  
  void refresh() {
    setState(() {});
  }
}
