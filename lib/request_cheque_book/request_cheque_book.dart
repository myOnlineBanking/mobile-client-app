import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RequestChequeBook extends StatefulWidget {
  @override
  _RequestChequeBook createState() => _RequestChequeBook();
}

class _RequestChequeBook extends State<RequestChequeBook> {
  bool isClicked = false;
  final borderRad = BorderRadius.circular(15.0);

  final borderside = BorderSide(
    color: Color(0xffe46b10),
  );

  var accountFrom;
  var beneficiary;

  var balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.cyan, Colors.cyan, Colors.cyanAccent]),
        ),
        child: Column(
          children: <Widget>[
            Column(
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
                        "Request Chequier",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Welcome \n FirstName Lastname",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    textAlign: TextAlign.center,
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
                            AssetImage('images/checkMark.png'),
                            color: Colors.greenAccent,
                            size: 50,
                          ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: balanceController,
                                enabled: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText: 'NB Books',
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: Icon(
                                      Icons.book_outlined,
                                      color: Colors.cyan,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: borderRad,
                                      borderSide: borderside,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: borderRad,
                                      borderSide: borderside,
                                    ),
                                    errorStyle: TextStyle(fontSize: 14)),
                                validator: (String? val) {
                                  if (val.toString().isEmpty) {
                                    return 'This Field Cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
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
                                  0: FractionColumnWidth(0.3)
                                },
                                children: [
                                  TableRow(children: [
                                    Center(
                                        child: Text(
                                      'NB Pages',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    )),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<Object>(
                                          isExpanded: true,
                                          value: accountFrom,
                                          items: [
                                            DropdownMenuItem(
                                              value: "25",
                                              child: Center(
                                                child: Text("25"),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "50",
                                              child: Center(
                                                child: Text("50"),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "100",
                                              child: Center(
                                                child: Text("100"),
                                              ),
                                            ),
                                          ],
                                          onChanged: (value) => {
                                                setState(() {}),
                                              }),
                                    ),
                                  ]),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              color: Colors.cyan[500],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () => {
                            setState(() {
                              var alertStyle = AlertStyle(
                                animationType: AnimationType.fromBottom,
                                isCloseButton: false,
                                isOverlayTapDismiss: false,
                                descStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                animationDuration: Duration(milliseconds: 400),
                                alertBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                titleStyle: TextStyle(
                                  color: Colors.green,
                                ),
                                alertAlignment: Alignment.center,
                              );
                              Alert(
                                style: alertStyle,
                                context: context,
                                title: "Success",
                                desc: "Operation Registred Successfully.",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();

                              isClicked = !isClicked;
                            }),
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
