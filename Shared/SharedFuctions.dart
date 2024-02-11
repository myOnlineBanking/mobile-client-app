import 'package:flutter/material.dart';

final Color ocpColor = Color(0xff3c56f5);
var borderRad = BorderRadius.circular(10.0);

InputDecoration inputDecoration(String label, var icon) {
  return InputDecoration(
    prefixIcon: icon,
    labelText: label,
    labelStyle: TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRad,
      borderSide: BorderSide(
        color: ocpColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRad,
      borderSide: BorderSide(
        color: ocpColor,
      ),
    ),
  );
}

Widget material(Color color, IconData icon, String label, Function? fun) {
  return Material(
    borderRadius: borderRad,
    color: color,
    child: MaterialButton(
      child: Row(
        children: <Widget>[
          // ignore: unnecessary_null_comparison
          icon != null
              ? Expanded(
                  flex: 1,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                )
              : Text(''),
          Expanded(
            flex: 10,
            child: Center(
              child: Text(
                '$label',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
      onPressed: () {},
    ),
  );
}

showdialog(var context, String title, Widget content,
    {required List<Widget> actions}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: actions,
        );
      });
}
