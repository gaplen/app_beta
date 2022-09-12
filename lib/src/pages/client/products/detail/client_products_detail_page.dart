import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ClientProductsDetailPage extends StatefulWidget {
  Product product;

  ClientProductsDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  _ClientProductsDetailPageState createState() =>
      _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  ClientProductsDetailController _con = ClientProductsDetailController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product);
    });
  }

  void _clickFavorites() {
    setState(() {
      print('esta activo');
      iconoFavoriteActivo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _imageSlideshow(),
          _textName(),
          _petInfo(),
          _ownerPet(),
          // _textDescription(),
          _buttonNext(),
        ],
      ),
    );
  }

  Widget iconoFavoriteActivo() {
    return Icon(
      Icons.favorite,
      color: Colors.red,
    );
  }

  Widget iconoFavoriteDesactivado() {
    return Icon(
      Icons.favorite_outline,
      color: Colors.grey,
    );
  }

  Widget _imageSlideshow() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.38,

          color: Color.fromRGBO(255, 251, 136, 1),

          // child: Lottie.asset(
          //   'assets/json/dog1.json',
          //   fit: BoxFit.cover,
          // ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.height * -0.05,
          top: MediaQuery.of(context).size.height * .16,
          child: Container(
            child: Image.asset('assets/img/huella.png'),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .25,
          left: MediaQuery.of(context).size.height * .58,
          child: Container(
            child: Transform(
                transform: Matrix4.rotationY(3.1416),
                child: Image.asset('assets/img/huella.png')),
          ),
        ),
        Center(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.12),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
                child: FadeInImage(
                image: _con.product?.image1 != null
                    ? NetworkImage(_con.product.image1)
                    : AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
                ),
          ),
        ),
        Positioned(
            left: 15,
            top: MediaQuery.of(context).size.height * 0.055,
            child: Container(
              width: 35,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                padding: EdgeInsets.only(right: 5),
                onPressed: _con.close,
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )),
      ],
    );
  }

  Widget _petInfo() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 120,
      width: MediaQuery.of(context).size.width * .9,
      //     color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 87,
            width: 99,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color.fromRGBO(197, 255, 197, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1.5,
                    blurRadius: 6,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    // color: Colors.red,
                    child: Text(
                      _con.product?.sex ?? '',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text(
                    'Sex',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 87,
            width: 99,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color.fromRGBO(131, 245, 245, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1.5,
                    blurRadius: 6,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    _con.product?.age ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Edad',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 87,
            width: 99,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color.fromRGBO(247, 255, 142, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1.5,
                    blurRadius: 6,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    _con.product?.weight ?? '',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Peso',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _textDescription() {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     margin: EdgeInsets.only(right: 30, left: 30, top: 15),
  //     child: Text(
  //       _con.product?.description ?? '',
  //       style: TextStyle(fontSize: 13, color: Colors.grey),
  //     ),
  //   );
  // }
  Widget _ownerPet() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .15),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image(image: AssetImage('assets/img/woman.png')),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  //   color: Colors.red,
                  width: MediaQuery.of(context).size.width * .32,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fabian',
                        // HACER UNA VALIDACION NOMAS DE 16 CARACTERES
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Chapis Owner',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade100,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            //  color: Colors.yellow,
            height: 90,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: 5, left: 15),
            child: SingleChildScrollView(
              child: Text(
                'Es un perro que vive en monterrey esta viejo huele a culo pero necesita una familia para que lo cuiden porque esta muy pendejo esta seria una descripción del puto animal hijo de su puta perra y rebomba madrelo cuiden porque esta muy pendejo esta seria una descripción del puto animal hijo de su puta perra y rebomba madrelo cuiden porque esta muy pendejo esta seria una descripción del puto animal hijo de su puta perra y rebomba madre',
                // _con.product?.description ?? '',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textName() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 30),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    _con.product?.name ?? '',
                    // _con.product?.name ?? '',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Icon(
                    Icons.pin_drop_outlined,
                    color: Colors.green,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Poza Rica, Ver.',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
        /* ICONO FAVORITOS */
        Positioned(
          top: 8,
          right: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            borderRadius: BorderRadius.circular(50),
            elevation: 5,
            child: IconButton(
                onPressed: () {
                  _clickFavorites();
                },
                icon: iconoFavoriteDesactivado()),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 50),
        //   height: 35,
        //   width: 35,
        //   decoration: BoxDecoration(boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 2,
        //       blurRadius: 5,
        //       offset: Offset(0, 1), // changes position of shadow
        //     ),
        //   ], borderRadius: BorderRadius.circular(50), color: Colors.grey[50]),
        //   child: Icon(
        //     Icons.favorite,
        //     color: Colors.red,
        //   ),
        // )
      ],
    );
  }

  Widget _buttonNext() {
    return Container(
      padding: EdgeInsets.only(top: 25),
      width: MediaQuery.of(context).size.width * 0.45,
      child: ElevatedButton(
        onPressed: _con.goToNewAddress,
        // aqui va mandar al cuestionario

        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'Adoptar',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
