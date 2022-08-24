import 'package:flutter/material.dart';

class PetsPage extends StatefulWidget {
  PetsPage({Key key}) : super(key: key);

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _questionPets(),
              _buttonNext(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionPets() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              height: 110,
              width: 300,
              // color: Colors.purple,
              child: Text(
                'Antes de adoptar, responda con sinceridad las siguientes preguntas.',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              child: Text('Cuento con el dinero para cubrir sus necesidades?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(value: 0, groupValue: 0, onChanged: null),
                SizedBox(
                  width: 100,
                ),
                Radio(value: 0, groupValue: 0, onChanged: null)
              ],
            ),
            SizedBox(height: 20),
            Container(
              child: Text('Tengo tiempo para mi nuevo amigo?.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(value: 0, groupValue: 0, onChanged: null),
                SizedBox(
                  width: 100,
                ),
                Radio(value: 0, groupValue: 0, onChanged: null)
              ],
            ),
            SizedBox(height: 20),
            Container(
              child:
                  Text('Tengo un espacio en casa y paciencia para educarlo?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(value: 0, groupValue: 0, onChanged: null),
                SizedBox(
                  width: 100,
                ),
                Radio(value: 0, groupValue: 0, onChanged: null)
              ],
            ),
            SizedBox(height: 20),
            Container(
              child: Text('Tiene alguna otra mascota en casa?.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(value: 0, groupValue: 0, onChanged: null),
                SizedBox(
                  width: 100,
                ),
                Radio(value: 0, groupValue: 0, onChanged: null)
              ],
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                'Esta consiente de la responsabilidad que implica tener un nueva mascota a su cargo.',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(value: 0, groupValue: 0, onChanged: null),
                SizedBox(
                  width: 100,
                ),
                Radio(value: 0, groupValue: 0, onChanged: null)
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: () {
          showAlertDialog(context);
          // Navigator.pushNamed(context, 'client/dialogpage');
        },
        // aqui va mandar al cuestionario
        // onPressed: _con.addToBag,
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
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     margin: EdgeInsets.only(left: 80, top: 9),
            //     height: 30,
            //     child: Icon(
            //       Icons.check_circle,
            //       color: Colors.green,
            //       size: 30,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
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
                  color: Colors.purple
                ),
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
            Text("!Gracias por tus respuestas!.", textAlign: TextAlign.center,),
            Text('Esta pequeña encuesta sera entraga al dueño de la mascota, que se esta dando en adopcion', textAlign: TextAlign.center,style: TextStyle(fontSize: 10,),)
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


}
