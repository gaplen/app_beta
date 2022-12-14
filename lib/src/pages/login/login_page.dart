import 'package:app_beta/src/pages/login/login_controller.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin()
            ),
            Positioned(
              child: _textLogin(),
              top: 60,
              left: 25,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _lottieAnimation(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount(), 
                  _contrasenaOlvidada(),  
                ],
              ),
            ),
             SizedBox(height: 30,),
           
          ],
        ),
      )
    );
  }

  Widget _lottieAnimation() {
    return Container(
      margin: EdgeInsets.only(
          top: 150,
          bottom: MediaQuery.of(context).size.height * 0.05
      ),
      child: Lottie.asset(
        'assets/json/pet2.json',
        width: 250,
        height: 250,
        fit: BoxFit.fill
      ),
    );
  }

  Widget _textLogin() {
    return Text(
      'Ingresar',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '??No tienes cuenta?',
          style: TextStyle(
              color: MyColors.primaryColorDark,
            fontSize: 17
          ),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(
            'Registrate',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColorDark,
                fontSize: 17
            ),
          ),
        ),
      ],
    );
  }

 Widget _contrasenaOlvidada() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: _con.goToLostPassword,
        child: Text(
          '??Olvid?? su contrase??a?',
          style: TextStyle(
              fontWeight: FontWeight.normal, color: Colors.black, fontSize: 17),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
        child: Text('INGRESAR', style: TextStyle(color: MyColors.primaryColorDark),),
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contrase??a',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo electronico',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }
  
  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor
      ),
    );
  }


}
