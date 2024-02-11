import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  var isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Request New Account",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Welcome FirstName Lastname",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Center(
            child: !isClicked
                ? ImageIcon(
                    AssetImage('images/questionMark.png'),
                    color: Colors.orangeAccent,
                    size: 50,
                  )
                : ImageIcon(
                    AssetImage('images/questionMark.png'),
                    color: Colors.greenAccent,
                    size: 50,
                  ),
          ),
        )
      ],
    );
  }
}
