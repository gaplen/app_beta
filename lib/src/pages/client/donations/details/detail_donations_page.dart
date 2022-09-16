import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/pages/client/donations/details/details_donation_page_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ClientDonationsDetailPage extends StatefulWidget {
  Donations donations;

  ClientDonationsDetailPage({Key key, @required this.donations}) : super(key: key);

  @override
  _ClientDonationsDetailPageState createState() => 
      _ClientDonationsDetailPageState();
}

class _ClientDonationsDetailPageState extends State<ClientDonationsDetailPage> {
  ClientDonationsDetailController _con = ClientDonationsDetailController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.donations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.40,

      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _imageSlideshow(),
          _textName(),
          _textDescription(),
          Spacer(),
          _addOrRemoveItem(),
          _buttonShoppingBag(),

          // _buttonNext(),
          // _buttonFavorite(),
          // _standartDelivery(),
        ],
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        _con.donations?.description ?? '',
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
            _con.donations?.name ?? '',
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
              _con.donations?.description ?? '',
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
                        image: _con.donations?.image1 != null
                            ? NetworkImage(_con.donations.image1)
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
                        image: _con.donations?.image2 != null
                            ? NetworkImage(_con.donations.image2)
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
                        image: _con.donations?.image3 != null
                            ? NetworkImage(_con.donations.image3)
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



  Widget _addOrRemoveItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          IconButton(
              onPressed: _con.addItem,
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
                size: 30,
              )
          ),
          Text(
            '${_con.counter}',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
          IconButton(
              onPressed: _con.removeItem,
              icon: Icon(
                Icons.remove_circle_outline,
                color: Colors.grey,
                size: 30,
              )
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              '${_con.productPrice ?? 0}\$',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }


Widget _buttonShoppingBag() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.addToBag,
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
                  'AGREGAR A LA BOLSA',
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
                margin: EdgeInsets.only(left: 50, top: 6),
                height: 30,
                // child: Image.asset('assets/img/bag.png'),
              ),
            )

          ],
        ),
      ),
    );
  }








  void refresh() {
    setState(() {});
  }
}
