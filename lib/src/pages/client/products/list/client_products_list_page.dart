import 'dart:ui';

import 'package:app_beta/src/models/category.dart';
import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:app_beta/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class ClientProductsListPage extends StatefulWidget {
  Product product;
  Category category;

  ClientProductsListPage({Key key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController _con = new ClientProductsListController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product, widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
        backgroundColor: Colors.cyan.shade100,
        key: _con.key,
        drawer: drawer(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    height: 20,
                  ),
                ),
                _myAppbar(),
                SizedBox(height: 5),
                animalCategory(),
                SizedBox(height: 15),
                nameCat(),
                cardPanel(),
              ],
            ),
          ),
        ),
        floatingActionButton: _buttonFlt(),
      ),
    );
  }

  Widget animalCategory() {
    return Material(
      color: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBar(
          // unselectedLabelStyle: TextStyle(color: Colors.red),
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          isScrollable: true,
          tabs: List<Widget>.generate(
            _con.categories.length,
            (index) {
              return Container(
                child: Image(
                  image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/nuevoproyecto-9fb14.appspot.com/o/image_1662933945507?alt=media&token=b8c61649-e616-473e-bf81-39ee4c1ccbe6"),
                ),

                
              );
              // return Row(
              //   children: [
              //     Container(
              //       height: 35,
              //       width: 40,
              //       decoration: BoxDecoration(
              //         // color: Colors.purple,
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //       child: FadeInImage(
              //         image: _con.category?.image != null
              //             ? NetworkImage(_con.category.image)
              //             : AssetImage('assets/img/no-image.png'),
              //         placeholder: AssetImage("assets/img/no-image.png"),
              //       ),
              //     ),
              //     Container(
              //       height: 50,
              //       width: 70,
              //       decoration: BoxDecoration(
              //         // color: Colors.purple,
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Center(
              //         child: Text(
              //           // "hola",
              //           _con.categories[index].name ?? '',

              //           style: TextStyle(),
              //         ),
              //       ),
              //     ),
              //   ],
              // );
            },
          ),
        ),
      ),
    );
  }

  Widget cardPanel() {
    return Container(
      // color: Colors.red,
      height: MediaQuery.of(context).size.height * 1,
      width: double.infinity,
      child: TabBarView(
        children: _con.categories.map((Category category) {
          return FutureBuilder(
              future: _con.getProducts(category.id, _con.productName),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.75),
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
    );
  }

  Widget imgCategory(Category category) {
    return CircleAvatar(
      child: Container(
        height: 60,
        margin: EdgeInsets.only(top: 10),
        child: FadeInImage(
          image: _con.category?.image != null
              ? NetworkImage(_con.category?.image)
              : AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget searh() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 45,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'buscar',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardProduct(Product product) {
    // final _random = Random();
    return GestureDetector(
      onTap: (){
         _con.openBottomSheet(product);
      },
      child: Container(
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/img/iconpaw.png',
                          ),
                          fit: BoxFit.contain),
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.only(top: 0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    // padding: EdgeInsets.all(20),
                  ),
                ),
                //image
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.2,
                  left: MediaQuery.of(context).size.height * 0.035,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.40,
                    // color: Colors.purple,

                    child: FadeInImage(
                      image: product.image1 != null
                          ? NetworkImage(
                              product.image1,
                            )
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
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
                      product.name ?? '',
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

  Widget _campNotf() {
    return GestureDetector(
      onTap: _con.goToOrderCreatePage,
      child: Stack(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            margin: EdgeInsets.only(right: 15, top: 0),
            child: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
            right: 16,
            top: 1,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchPets() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      // margin: EdgeInsets.symmetric(horizontal: 60),
      child: TextField(
        onChanged: _con.onChangeText,
        decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: Icon(Icons.search, color: Colors.black),
            hintStyle: TextStyle(fontSize: 17, color: Colors.black),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white)),
            contentPadding: EdgeInsets.all(15)),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        // color: Colors.red,
        // height: MediaQuery.of(context).size.height * 0.070,
        // width: MediaQuery.of(context).size.width * 0.15,
        margin: EdgeInsets.only(left: 15, top: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: 45,
            width: 45,
            child: FadeInImage(
              image: _con.user?.image != null
                  ? NetworkImage(_con.user?.image)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.red,
                  //       fontWeight: FontWeight.bold),
                  //   maxLines: 1,
                  // ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        _con.user?.name ?? '',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        maxLines: 1,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _con.user?.lastname ?? '',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                ],
              )),
          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text('Mi Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),

          ListTile(
            onTap: _con.goToFavoritePage,
            title: Text('Favoritos'),
            trailing: Icon(Icons.favorite),
          ),
          ListTile(
            onTap: _con.goToDonationPage,
            title: Text('Donaciones'),
            trailing: Icon(Icons.money),
          ),

          // ListTile(
          //   onTap: _con.goToOrdersList,
          //   title: Text('Mis pedidos'),
          //   trailing: Icon(Icons.shopping_cart_outlined),
          // ),
          // ListTile(
          //   onTap: _con.goToFavoritePage,
          //   title: Text('Favoritos'),
          //   trailing: Icon(Icons.favorite),
          // ),
          _con.user != null
              ? _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Seleccionar rol'),
                      trailing: Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  Widget _myAppbar() {
    return Container(
      child: Row(
        children: [
          _menuDrawer(),
          Spacer(),
          _searchPets(),
          Spacer(),

          _campNotf(),
          // _textFieldSearch(),
          // Container(
          //   height: 40,
          //   width: 40,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Colors.grey.shade300),
          //   margin: EdgeInsets.only(right: 0, top: 0),
          //   child: IconButton(
          //     onPressed: () => showSearch(
          //       context: context,
          //       delegate: ProductSearchDelegate(),
          //     ),
          //     icon: Icon(Icons.search),
          //     color: Colors.black,
          //   ),
          // ),

          SizedBox(width: 5),
          // _shoppingBag()
        ],
      ),
    );
    // return AppBar(
    //           automaticallyImplyLeading: false,
    //           backgroundColor: Colors.purple,
    //           actions: [_shoppingBag()],
    //           flexibleSpace: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(height: 40),
    //               _menuDrawer(),
    //               SizedBox(height: 0),
    //               _textFieldSearch(),
    //               SizedBox(height: 10),
    //               Container(
    //                   margin: EdgeInsets.only(left: 20),
    //                   child: Text(
    //                     'Categorias',
    //                     style: TextStyle(fontSize: 20),
    //                   )),
    //               SizedBox(
    //                 height: 30,
    //               )
    //             ],
    //           ),
    //           bottom: TabBar(
    //             indicatorColor: Colors.red,
    //             labelColor: Colors.black,
    //             unselectedLabelColor: Colors.red[400],
    //             isScrollable: true,
    //             tabs: List<Widget>.generate(_con.categories.length, (index) {
    //               return Tab(
    //                 child: Text(_con.categories[index].name ?? ''),
    //               );
    //             }),
    //           ),
    //         );
  }

  Widget nameCat() {
    return Container(
        height: 30,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Colors.orange),
        // margin: EdgeInsets.only(left: 10),
        child: Center(
          child: Text(
            'Nueva familia',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15),
          ),
        ));
  }

  _buttonFlt() {
    return FloatingActionButton(
      focusColor: Colors.pink,
      splashColor: Colors.red,
      backgroundColor: Colors.black,
      child: Icon(Icons.pets_outlined),
      onPressed: _con.goToGivePet,
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
