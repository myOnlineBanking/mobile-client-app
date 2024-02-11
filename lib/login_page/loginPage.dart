import 'dart:convert';

import 'package:app_for_test/alerts/login_loading.dart';
import 'package:app_for_test/homePage/home_page.dart';
import 'package:app_for_test/services/SecureStorage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'bezierContainer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:app_for_test/shared/Constants.dart' as constants;

import './models/loginResponse.dart';
import '../signupPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key = const Key("Default Key"), this.title = "Default Title"})
      : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Widget _backButton() {
  //   return InkWell(
  //       onTap: () {
  //         Navigator.pop(context);
  //       },
  //       child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           child: Row(children: <Widget>[
  //             Container(
  //               padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
  //               child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
  //             ),
  //             Text('Back',
  //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
  //           ])));
  // }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 10),
              TextField(
                  controller:
                      isPassword ? passwordController : usernameController,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ]));
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () async {
        LoginLoading.showLoaderDialog(context);

        var payload = json.encode({
          "username": usernameController.text,
          "password": passwordController.text
        });
        var response = await http.post(
          Uri.parse(constants.LOGIN_URL),
          body: payload,
          headers: {"Content-Type": "application/json"},
        );
        print("Login response" + response.body.toString());
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
            desc: "Incorrect login or password.",
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
          Map<String, dynamic> map = jsonDecode(response.body);
          LoginResponse loginResponse = LoginResponse.fromJson(map);

          await SecureStorage.writeSecureData(
              "token", loginResponse.accessToken.toString());

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(user: loginResponse)));
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
          child: Text('Login',
              style: TextStyle(fontSize: 20, color: Colors.white))),
    );
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(thickness: 1))),
          Text('or'),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(thickness: 1))),
          SizedBox(width: 20)
        ]));
  }

  Widget _facebookButton() {
    return Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF8EA8C),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topLeft: Radius.circular(5))),
                  alignment: Alignment.center,
                  child: Text('A',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w400)))),
          Expanded(
              flex: 5,
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffBCECE0),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: Text('Contact Admin',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400))))
        ]));
  }

  Widget _createAccountLabel() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('Register',
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
            text: 'E-',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffA4E8E0),
            ),
            children: [
              TextSpan(
                text: 'Bank',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'ING',
                style: TextStyle(color: Color(0xffA4E8E0), fontSize: 30),
              )
            ]));
  }

  Widget _emailPasswordWidget() {
    return Column(children: <Widget>[
      _entryField("Username"),
      _entryField("Password", isPassword: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: <Widget>[
                Expanded(flex: 6, child: SizedBox()),
                _title(),
                SizedBox(height: 50),
                _emailPasswordWidget(),
                SizedBox(height: 20),
                _submitButton(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password ?',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                _divider(),
                _facebookButton(),
                Expanded(flex: 2, child: SizedBox())
              ])),
          Align(
            alignment: Alignment.bottomCenter,
            child: _createAccountLabel(),
          ),
          // Positioned(top: 40, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ]));
  }
}
