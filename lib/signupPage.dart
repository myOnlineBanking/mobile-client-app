import 'dart:convert';

import 'package:app_for_test/create_account/ContinueRegistration.dart';
import 'package:app_for_test/services/SecureStorage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'login_page/bezierContainer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'login_page/loginPage.dart';

import 'package:app_for_test/shared/Constants.dart' as constants;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key = const Key("Default Key"), this.title = "Default Title"})
      : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _backButton() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  child: Icon(Icons.keyboard_arrow_left, color: Colors.black)),
              Text('Back',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
            ])));
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  Widget _entryField(String title,
      {bool isPassword = false, bool isEmail = false}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 10,
              ),
              TextField(
                  obscureText: isPassword,
                  controller: isPassword
                      ? passwordController
                      : isEmail
                          ? emailController
                          : usernameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ]));
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () async {
        var payload = json.encode({
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "roles": ["user"]
        });

        var response = await http.post(
          Uri.parse(constants.SIGNUP_URL),
          body: payload,
          headers: {"Content-Type": "application/json"},
        );

        Map<String, dynamic> map = jsonDecode(response.body);
        print("I have returned " + map.toString());

        if (response.statusCode != 200) {
          var alertStyle = AlertStyle(
            animationType: AnimationType.fromBottom,
            isCloseButton: false,
            isOverlayTapDismiss: false,
            descStyle: TextStyle(fontWeight: FontWeight.bold),
            animationDuration: Duration(milliseconds: 400),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.grey,
              ),
            ),
            titleStyle: TextStyle(
              color: Colors.red,
            ),
            alertAlignment: Alignment.center,
          );
          Alert(
            style: alertStyle,
            context: context,
            title: "Error",
            desc: map['message'].toString(),
            buttons: [
              DialogButton(
                child: Text(
                  "Retry",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        } else {
          // Write value
          await SecureStorage.writeSecureData(
              "username", usernameController.text);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ContinueRegistration(username: usernameController.text)));
        }
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
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
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.cyanAccent, Colors.cyan])),
          child: Text('Send Request',
              style: TextStyle(fontSize: 20, color: Colors.white))),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text('Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Login',
                  style: TextStyle(
                      color: Color(0xfff79c4f),
                      fontSize: 13,
                      fontWeight: FontWeight.w600)))
        ]));
  }

  Widget _title() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'E',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffA4E8E0),
            ),
            children: [
              TextSpan(
                text: '-BANK',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'ING',
                style: TextStyle(color: Color(0xffA4E8E0), fontSize: 30),
              )
            ]));
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryField("Email", isEmail: true),
        _entryField("Password", isPassword: true)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(flex: 3, child: SizedBox()),
                    _title(),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    Expanded(flex: 2, child: SizedBox())
                  ])),
          Align(
            alignment: Alignment.bottomCenter,
            child: _loginAccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ]));
  }
}
