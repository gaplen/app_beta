import 'package:app_beta/src/models/category.dart';
import 'package:app_beta/src/models/donations.dart';
import 'package:app_beta/src/pages/client/donations/controller_donation_page.dart';
import 'package:app_beta/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class ClientDontationsPage extends StatefulWidget {
  Donations donations;

  ClientDontationsPage({Key key}) : super(key: key);

  @override
  _ClientDontationsPageState createState() => _ClientDontationsPageState();
}

class _ClientDontationsPageState extends State<ClientDontationsPage> {
  ClientDonationsController _con = new ClientDonationsController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.donations);
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Donaciones'),
          centerTitle: true,
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: _con.okBtn,
              icon: Icon(Icons.help)),
          )],
        ),
        backgroundColor: Colors.cyan.shade100,
        key: _con.key,
        // drawer: drawer(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: Container(
                    height: 100,
                  ),
                ),
                cardPanel(),
                cardPanel(),
               
              ],
            ),
          ),
        ),
        // floatingActionButton: _buttonFlt(),
      ),
    );
  }


  Widget cardPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(
          color: Colors.red,
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          child: TabBarView(
            children: _con.categories.map((Category category) {
              return FutureBuilder(
                  future: _con.getProducts(category.id, _con.productName),
                  builder: (context, AsyncSnapshot<List<Donations>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.75),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return _cardProduct(
                              snapshot.data[index],
                            );
                          },
                        );
                      } else {
                        return NoDataWidget(text: 'No hay mascotas');
                      }
                    } else {
                      return NoDataWidget(text: 'No hay mascotas');
                    }
                  });
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _cardProduct(Donations donations) {
    // final _random = Random();
    return GestureDetector(
      onTap: () {
        // _con.openBottomSheet(donations);
      },
      child: Container(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                     
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.only(top: 0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    // padding: EdgeInsets.all(20),
                  ),
                ),
                //image
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.1,
                  left: MediaQuery.of(context).size.height * 0.035,
                  child: Container(
                    // height: 150,
                    // width: MediaQuery.of(context).size.width * 0.30,
                    // color: Colors.purple,

                    child: FadeInImage(
                      image: donations.image1 != null
                          ? NetworkImage(
                              donations.image1,
                            )
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      height: 100,
                    ),
                  ),
                ),

                //Textname
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    // color: Colors.purple,
                    child: Text(
                      donations.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'NimbusSans'),
                    ),
                  ),
                ),
                //Favorite
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.38,
                  child: Container(
                    height: 20,
                    width: 20,
                    // color: Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  


  void refresh() {
    setState(() {}); // CTRL + S
  }
}




