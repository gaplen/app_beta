import 'package:app_beta/src/models/product.dart';
import 'package:app_beta/src/provider/products_provider.dart';
import 'package:flutter/material.dart';

class PetsSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Busca Tu mascota';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.backspace_outlined),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Text('no hay valor');
    }

    final productos = new PetsProvider();

    return FutureBuilder(
      future: productos.findByProductName(query),
      builder: (BuildContext contex, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return showPets(snapshot.data);
        } else {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 4,
          ));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(title: Text('Suggestions'));

    // if (query.isEmpty) {
    //   return Center(
    //     child: Container(
    //       // color: Colors.red,
    //       height: MediaQuery.of(context).size.height * 0.4,
    //       width: MediaQuery.of(context).size.width * 0.5,
    //       child: Container(
    //         child: Lottie.asset('assets/json/doog.json'),
    //       ),
    //     ),
    //   );
    // }
    // return Container();
  }

  Widget showPets(List<Product> productName) {
    return ListView.builder(
      itemCount: productName.length,
      itemBuilder: (_, i) {
        final pets = productName[i];

        return ListTile(
          title: Text(pets.name),
        );
      },
    );
  }
}
