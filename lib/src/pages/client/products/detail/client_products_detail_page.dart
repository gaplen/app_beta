import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/pages/client/products/detail/client_products_detail_controller.dart';

import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _imageSlideshow(),
            _textName(),
            _petInfo(),
            _ownerPet(),
            _textDescription(),
            // // _addOrRemoveItem(),

            _buttonNext(),
            // _buttonFavorite(),
            // _standartDelivery(),
          ],
        ),
      ),
    );
  }

  Widget _ownerPet() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 20.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'descripcion',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade100,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _petInfo() {
    return Container(
      height: 120,
      width: double.infinity,
      // color: Colors.purple,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100,
                  ),
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Sexo',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow.shade100),
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
                              fontSize: 20),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Edad',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          _con.product?.weight?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Peso',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        _con.product?.description ?? '',
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 30),
      child: Row(
        children: [
          Text(
            _con.product?.name ?? '',
            // _con.product?.name ?? '',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),

          Spacer(),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.15,
          //   height: MediaQuery.of(context).size.height * 0.07,
          //   decoration: BoxDecoration(
          //       color: Colors.grey.shade200,
          //       borderRadius: BorderRadius.circular(15)),

          //   // margin: EdgeInsets.only(left: 50, top: 6),
          //   // height: 30,
          //   // child: IconButton(
          //   //     // icon: Icon(Icons.safety_divider),
          //   //     icon: Icon(
          //   //       liked ? Icons.favorite : Icons.favorite,
          //   //       color: liked
          //   //           ? Colors.red ?? _con.addItem
          //   //           : Colors.grey ?? _con.removeItem,
          //   //       size: 30,
          //   //     ),
          //   //     onPressed: () async {
          //   //       if (liked)
          //   //         _con.addFavorite();
          //   //       else {
          //   //         _con.removeItem();
          //   //       }

          //   //       _con.addFavorite();
          //   //       _persistPreference();
          //   //     }),
          // ),
          Container(
            child: Text(
              _con.product?.description ?? '',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.goToNewAddress,
        // aqui va mandar al cuestionario
       
        style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade100,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Adoptame',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSlideshow() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: double.infinity,
          color: Colors.red.shade100,
          child: Lottie.asset(
            'assets/json/dog1.json',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(

              // color: Colors.yellow.shade100

              ),
          height: MediaQuery.of(context).size.height * 0.4,
          //width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1 / 0.59,
                  viewportFraction: 1.0,
                ),
                items: [
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.10,
                    // width: MediaQuery.of(context).size.width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: 
                      FadeInImage(
                        image: _con.product?.image1 != null
                            ? NetworkImage(_con.product.image1)
                            : AssetImage('assets/img/no-image.png'),
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 50),
                        placeholder: AssetImage('assets/img/no-image.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.10,
                    // width: MediaQuery.of(context).size.width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        image: _con.product?.image2 != null
                            ? NetworkImage(_con.product.image2)
                            : AssetImage('assets/img/no-image.png'),
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 50),
                        placeholder: AssetImage('assets/img/no-image.png'),
                      ),
                    ),
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.10,
                    // width: MediaQuery.of(context).size.width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        image: _con.product?.image3 != null
                            ? NetworkImage(_con.product.image3)
                            : AssetImage('assets/img/no-image.png'),
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 50),
                        placeholder: AssetImage('assets/img/no-image.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            left: 15,
            top: MediaQuery.of(context).size.height * 0.04,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: _con.close,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            )),
        Positioned(
          top: 20,
          right: 10,
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
