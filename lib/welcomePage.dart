import 'package:app_for_test/create_account/ContinueRegistration.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

import 'login_page/loginPage.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage(
      {Key key = const Key("Default Key"), this.title = "Default Title"})
      : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 13),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xffdf8e33).withAlpha(100),
                      offset: Offset(2, 4),
                      blurRadius: 8,
                      spreadRadius: 2)
                ],
                color: Colors.white),
            child: Text('Login',
                style: TextStyle(fontSize: 20, color: Color(0xfff7892b)))));
  }

  Widget _signUpButton() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              //Change Here
              MaterialPageRoute(
                  builder: (context) => ContinueRegistration(
                        username: '',
                      )));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 13),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text('Register now',
                style: TextStyle(fontSize: 20, color: Colors.white))));
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(children: <Widget>[
          Text('Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17)),
          SizedBox(height: 20),
          Icon(Icons.fingerprint, size: 90, color: Colors.white),
          SizedBox(height: 20),
        ]));
  }

  Widget _title() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'F',
            style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            children: [
              TextSpan(
                  text: 'LU',
                  style: TextStyle(color: Colors.black, fontSize: 30)),
              TextSpan(
                  text: 'TTER',
                  style: TextStyle(color: Colors.white, fontSize: 30))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                SizedBox(height: 80),
                _submitButton(),
                SizedBox(height: 20),
                _signUpButton(),
                SizedBox(
                  height: 20,
                ),
                _label()
              ]))
    ]));
  }
}
