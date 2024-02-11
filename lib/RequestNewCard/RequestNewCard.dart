import 'package:app_for_test/alerts/my_alert.dart';
import 'package:app_for_test/models/Account.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/services/account_service.dart';
import 'package:app_for_test/services/card_service.dart';
import 'package:flutter/material.dart';

class RequestNewCard extends StatefulWidget {
  const RequestNewCard({Key? key, required this.client}) : super(key: key);

  @override
  _RequestNewCard createState() => _RequestNewCard();
  final Client client;
}

class _RequestNewCard extends State<RequestNewCard> {
  @override
  void initState() {
    super.initState();
    _accountsService
        .getAccountsOfClient(widget.client.id)
        .then((value) => _userAccounts = value);
  }

  bool isClicked = false;
  final borderRad = BorderRadius.circular(15.0);

  final borderside = BorderSide(
    color: Colors.cyan,
  );

  var cardType;
  var accountCurrency;
  CardService _cardService = new CardService();
  var accountFrom;

  AccountService _accountsService = new AccountService();
  List<Account> _userAccounts = [];

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
                        "Request New Card",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
              child: SingleChildScrollView(
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
                                                color: Colors.grey,
                                                fontSize: 16),
                                          )),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<Object>(
                                                isExpanded: true,
                                                value: cardType,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "VISA",
                                                    child: Center(
                                                      child: Text("Visa"),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "VIRTUAL",
                                                    child: Center(
                                                      child: Text("Virtual"),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "MASTERCARD",
                                                    child: Center(
                                                      child:
                                                          Text("Master Card"),
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (value) => {
                                                      setState(() {
                                                        cardType =
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
                            //Account ----------------------------------------
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
                                            'Account',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          )),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<Object>(
                                                isExpanded: true,
                                                value: accountFrom,
                                                items: _userAccounts
                                                    .map(
                                                      (account) =>
                                                          DropdownMenuItem(
                                                        value: account.id,
                                                        child: Center(
                                                          child: Text(account
                                                              .accountNumber
                                                              .toString()),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) => {
                                                      setState(() {
                                                        accountFrom =
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
                            _cardService.requestNewCard(accountFrom, {
                              "type": cardType,
                              "cardHolderName": widget.client.firstname
                                      .toString()
                                      .toUpperCase() +
                                  " " +
                                  widget.client.lastname
                                      .toString()
                                      .toUpperCase()
                            }).then((value) => {
                                  MyAlert()
                                      .getAlert(context,
                                          "Card request has been Saved", true)
                                      .show()
                                });
                          }),
                        },
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
