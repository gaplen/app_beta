import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/pages/client/products/favorite/client_orders_favorite_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:app_beta/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientFavoriteCreatePage extends StatefulWidget {
  const ClientFavoriteCreatePage({Key key}) : super(key: key);

  @override
  _ClientFavoriteCreatePageState createState() => _ClientFavoriteCreatePageState();
}

class _ClientFavoriteCreatePageState extends State<ClientFavoriteCreatePage> {

  ClientFavoriteCreateController _con = new ClientFavoriteCreateController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        
        //width: MediaQuery.of(context).size.width * 0.30,
        child: Column(
          children: [ 
            Divider(
              color: Colors.grey[400],
              endIndent: 30, // DERECHA
              indent: 30, //IZQUIERDA
            ),
            // _textTotalPrice(),
             _buttonNext()
          ],
        ),
      ),
      body: 
      
      _con.selectedProducts.length > 0
      ? ListView(
        children: _con.selectedProducts.map((Product product) {
          return GestureDetector(
            onTap: (){
               _con.openBottomSheet(product);
              print('puto carlos');
            },
            child: _cardProduct(product));
        }).toList(),
      )
      : NoDataWidget(text: 'No tienes mascotas agregadas',),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: (){
          Navigator.pop(context);
          // _showAlertDialog(context);
        },
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
                  'Ok',
                  style: TextStyle(
                    color: Colors.black,
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


  Widget _cardProduct(Product product) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            _imageProduct(product),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                // _addOrRemoveItem(product)
              ],
            ),
            Spacer(),
            Column(
              children: [
                // _textPrice(product),
                _iconDelete(product)
              ],
            )
          ],
        ),
    );
  }
  
  Widget _iconDelete(Product product) {
    return IconButton(
        onPressed: () {
          _con.deleteItem(product);
        },
        icon: Icon(Icons.delete, color: MyColors.primaryColor,)
    );
  }



  Widget _imageProduct(Product product) {
    return Container(
      width: 90,
      height: 90,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200]
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1)
            : AssetImage('assets/img/no-image.png'),
        fit: BoxFit.contain,
        fadeInDuration: Duration(milliseconds: 50),
        placeholder: AssetImage('assets/img/no-image.png'),
      ),
    );
  }

  
  void refresh() {
    setState(() {});
  }
}
