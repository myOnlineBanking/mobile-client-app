import 'package:app_for_test/login_page/loginPage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Flutter Tutorial',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
                bodyText2:
                    GoogleFonts.montserrat(textStyle: textTheme.bodyText2))),
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}
