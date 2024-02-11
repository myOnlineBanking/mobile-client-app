import 'package:flutter/material.dart';

import 'Button.dart';

class InputWrapper extends StatefulWidget {
  @override
  _InputWrapperState createState() => _InputWrapperState();
}

class _InputWrapperState extends State<InputWrapper> {
  final borderRad = BorderRadius.circular(15.0);

  final borderside = BorderSide(
    color: Color(0xffe46b10),
  );

  var accountType;

  var accountCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Container(
                    height: 58,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      borderRadius: borderRad,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FractionColumnWidth(0.23)
                          },
                          children: [
                            TableRow(children: [
                              Center(
                                  child: Text(
                                'Type',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<Object>(
                                    isExpanded: true,
                                    value: accountType,
                                    items: [
                                      DropdownMenuItem(
                                        value: "Normal",
                                        child: Center(
                                          child: Text("Normal"),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "Saving",
                                        child: Center(
                                          child: Text("Saving"),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "Other",
                                        child: Center(
                                          child: Text("Other"),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => {
                                          setState(() {
                                            accountType = value.toString();
                                          }),
                                        }),
                              ),
                            ]),
                          ]),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 58,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      borderRadius: borderRad,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FractionColumnWidth(0.3)
                          },
                          children: [
                            TableRow(children: [
                              Center(
                                  child: Text(
                                'Currency',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<Object>(
                                    isExpanded: true,
                                    value: accountCurrency,
                                    items: [
                                      DropdownMenuItem(
                                        value: "Dollar",
                                        child: Center(
                                          child: Text("Dollar"),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "Euro",
                                        child: Center(
                                          child: Text("Euro"),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "MAD",
                                        child: Center(
                                          child: Text("MAD"),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => {
                                          setState(() {
                                            accountCurrency = value.toString();
                                          }),
                                        }),
                              ),
                            ]),
                          ]),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Button()
        ],
      ),
    );
  }
}
