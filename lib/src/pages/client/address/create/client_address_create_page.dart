import 'package:app_beta/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({Key key}) : super(key: key);

  @override
  _ClientAddressCreatePageState createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {

  ClientAddressCreateController _con = new ClientAddressCreateController();

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
        title: Text('Encuesta'),
      ),
      bottomNavigationBar: _buttonAccept(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _txtTitle(),
            _txtUno(),
            _txtDos(),
            _txtTres(),
            _txtCuatro(),
            _txtMap(),
           
            // _textFieldRefPoint()
          ],
        ),
      ),
    );
  }

  Widget _txtUno() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Text('Aliquip deserunt laborum labore irure Lorem et qui eiusmod consequat.'),
          
          TextField(
          
            controller: _con.txt1Controller,
            decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 12
            ),
            
            labelText: 'Escribe tu respuesta',
            
              // suffixIcon: Icon(
              //   Icons.location_city,
              //   color: MyColors.primaryColor,
              // )
            ),
          ),
        ],
      ),
    );
  }
  Widget _txtDos() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Text('Aliquip deserunt laborum labore irure Lorem et qui eiusmod consequat.'),
          
          TextField(
            controller: _con.txt2Controller,
             decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 12
            ),
            
            labelText: 'Escribe tu respuesta',
            
              // suffixIcon: Icon(
              //   Icons.location_city,
              //   color: MyColors.primaryColor,
              // )
            ),
          ),
        ],
      ),
    );
  }

  Widget _txtTres() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Text('Aliquip deserunt laborum labore irure Lorem et qui eiusmod consequat.'),
          
          TextField(
            keyboardType: TextInputType.phone,
            controller: _con.txt3Controller,
             decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 12
            ),
            
            labelText: 'Escribe tu respuesta',
            
              // suffixIcon: Icon(
              //   Icons.location_city,
              //   color: MyColors.primaryColor,
              // )
            ),
          ),
        ],
      ),
    );
  }

  Widget _txtMap() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          labelText: 'Punto de referencia',
          suffixIcon: Icon(
            Icons.map,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _txtCuatro() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Text('Aliquip deserunt laborum labore irure Lorem et qui eiusmod consequat.'),
          
          TextField(
            controller: _con.txt4Controller,
            decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: 12
            ),
            
            labelText: 'Escribe tu respuesta',
            
              // suffixIcon: Icon(
              //   Icons.location_city,
              //   color: MyColors.primaryColor,
              // )
            ),
          ),
        ],
      ),
    );
  }

  Widget _txtTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Contesta la siguientes preguntas',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        
        onPressed: _con.createAddress,
        child: Text(
            'Continuar', style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;


  
}

 
