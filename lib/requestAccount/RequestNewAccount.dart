import 'package:app_for_test/alerts/my_alert.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/services/account_service.dart';
import 'package:flutter/material.dart';

class RequestNewAccount extends StatefulWidget {
  final Client client;

  const RequestNewAccount({Key? key, required this.client}) : super(key: key);

  @override
  _RequestNewAccount createState() => _RequestNewAccount();
}

class _RequestNewAccount extends State<RequestNewAccount> {
  bool isClicked = false;
  final borderRad = BorderRadius.circular(15.0);

  final borderside = BorderSide(
    color: Color(0xffe46b10),
  );

  var accountType;
  var accountCurrency;
  AccountService _accountsService = new AccountService();

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
                        "Request New Account",
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
                    "Welcome \n" +
                        widget.client.firstname.toString() +
                        " " +
                        widget.client.lastname.toString(),
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
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
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
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        )),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<Object>(
                                              isExpanded: true,
                                              value: accountType,
                                              items: [
                                                DropdownMenuItem(
                                                  value: "NORMAL",
                                                  child: Center(
                                                    child: Text("Normal"),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "SAVING",
                                                  child: Center(
                                                    child: Text("Saving"),
                                                  ),
                                                ),
                                              ],
                                              onChanged: (value) => {
                                                    setState(() {
                                                      accountType =
                                                          value.toString();
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
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        )),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<Object>(
                                              isExpanded: true,
                                              value: accountCurrency,
                                              items: [
                                                DropdownMenuItem(
                                                  value: "DOLLAR",
                                                  child: Center(
                                                    child: Text("Dollar"),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "EURO",
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
                                                      accountCurrency =
                                                          value.toString();
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
                    GestureDetector(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          color: Colors.cyan[500],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Send Request",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () => {
                        setState(() {
                          isClicked = !isClicked;
                          _accountsService.requestNewAccount(widget.client.id, {
                            "currency": accountCurrency,
                            "type": accountType
                          });
                          MyAlert()
                              .getAlert(
                                  context, "Account has been created", true)
                              .show();
                        }),
                      },
                    )
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
