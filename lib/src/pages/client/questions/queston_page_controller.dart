import 'package:app_beta/src/models/address.dart';
import 'package:app_beta/src/models/response_api.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/pages/client/address/map/client_address_map_page.dart';
import 'package:app_beta/src/provider/address_provider.dart';
import 'package:app_beta/src/utils/my_snackbar.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class QuestionPageController {
  BuildContext context;
  Function refresh;



  TextEditingController refPointController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController neighborhoodController = new TextEditingController();

  TextEditingController txt1Controller = new TextEditingController();
  TextEditingController txt2Controller = new TextEditingController();
  TextEditingController txt3Controller = new TextEditingController();
  TextEditingController txt4Controller = new TextEditingController();
  // TextEditingController refPointController = new TextEditingController();

  Map<String, dynamic> refPoint;

  AddressProvider _addressProvider = new AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user);
  }


  void createAddress() async {
    String preguntaUno = txt1Controller.text;
    String preguntaDos = txt2Controller.text;
    String preguntaTres = txt3Controller.text;
    String preguntaCuatro = txt4Controller.text;

    

    if (preguntaUno.isEmpty ||
        preguntaDos.isEmpty ||
        preguntaTres.isEmpty ||
        preguntaCuatro.isEmpty
        ) {
      MySnackbar.show(context, 'Completa todos los campos');
      return;
    }

    Address address = new Address(
        address: preguntaUno,
        neighborhood: preguntaDos,
        postalCode: preguntaTres,
        telephono: preguntaCuatro,
        
        idUser: user.id);

    ResponseApi responseApi = await _addressProvider.create(address);

    if (responseApi.success) {
      address.id = responseApi.data;
      _sharedPref.save('address', address);

      Fluttertoast.showToast(msg: responseApi.message);
      myshowAlertDialog(context);
      // Navigator.pop(context, true);
      // Navigator.popAndPushNamed(context, 'client/products/list');
    }
  }

  void openMap() async {
    refPoint = await showMaterialModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => ClientAddressMapPage());

    if (refPoint != null) {
      refPointController.text = refPoint['address'];
      refresh();
    }
  }
}

myshowAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Container(
      // color: Colors.purple,
      child: Column(
        children: [
          Text("OK"),
        ],
      ),
    ),
    onPressed: () {
      // Navigator.pop(context);
      Navigator.pushNamed(context, 'client/products/list');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Container(
      height: 200,
      width: 200,
      // color: Colors.green,
      child: Column(
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: Colors.purple),
            ),
          )
        ],
      ),
    ),
    content: Container(
      height: 50,
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "!Gracias por tus respuestas!.",
            textAlign: TextAlign.center,
          ),
          Text(
            'Esta pequeña encuesta sera entraga al dueño de la mascota, que se esta dando en adopcion',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
