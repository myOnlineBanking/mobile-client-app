import 'package:app_for_test/alerts/login_loading.dart';
import 'package:app_for_test/alerts/my_alert.dart';
import 'package:app_for_test/models/Account.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/models/Recipient.dart';
import 'package:app_for_test/services/account_service.dart';
import 'package:app_for_test/services/client_service.dart';
import 'package:app_for_test/services/transfer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MakeTransfer extends StatefulWidget {
  final userId;

  const MakeTransfer({Key? key, this.userId}) : super(key: key);

  @override
  _MakeTransfer createState() => _MakeTransfer();
}

class _MakeTransfer extends State<MakeTransfer> {
  @override
  void initState() {
    super.initState();
    fillUserAccounts(widget.userId);

    _clientService.getClientInfo(widget.userId).then(
          (value) => setState(
            () {
              userfilled = true;
              user = value;
              print(user!.firstname.toString() +
                  " " +
                  user!.lastname.toString() +
                  " " +
                  user!.id.toString());
              firstNameLastName =
                  user!.firstname.toString() + " " + user!.lastname.toString();
            },
          ),
        );
    _clientService.getRecipients(widget.userId).then((value) => {
          setState(() {
            print(value);
            recipients = value;
            recipientsLoaded = true;
          }),
        });
  }

  bool recipientsLoaded = false;

  Recipient? selectedRecipient;
  List<Recipient>? recipients;

  String? groupName = "Default";

  bool isClicked = false;
  bool transferSent = false;
  final borderRad = BorderRadius.circular(15.0);

  final borderside = BorderSide(
    color: Color(0xffe46b10),
  );

  final cyanBorderside = BorderSide(
    color: Colors.cyan,
  );

  var accountFrom;
  var transferType = "TO_CASH";
  var transferNumberType = "";
  var chargesType = "FROM_ME";

  var accountNumberController = TextEditingController();
  var recipientEmailController = TextEditingController();

  var balanceController = TextEditingController();

  AccountService _accountsService = new AccountService();
  ClientService _clientService = new ClientService();
  List<Account> _userAccounts = [];
  TransferService _transferService = new TransferService();
  Client? user;

  bool userfilled = false;
  bool accountfilled = false;
  String? firstNameLastName = " ";

  @override
  Widget build(BuildContext context) {
    print(transferSent);
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
                        "Transfer Money",
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
                    "Welcome \n " + firstNameLastName.toString(),
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
                ),
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
                                                      .map((account) =>
                                                          DropdownMenuItem(
                                                            value: account
                                                                .accountNumber,
                                                            child: Center(
                                                              child: Text(account
                                                                  .accountNumber
                                                                  .toString()),
                                                            ),
                                                          ))
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
                              SizedBox(
                                height: 20,
                              ),
                              //TRANSFER Type ----------------------------------
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
                                          0: FractionColumnWidth(0.4)
                                        },
                                        children: [
                                          TableRow(children: [
                                            Center(
                                              child: Text(
                                                'Transfer Type',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<Object>(
                                                  isExpanded: true,
                                                  value: transferType,
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: "TO_ACCOUNT",
                                                      child: Center(
                                                        child:
                                                            Text("To Account"),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "TO_CASH",
                                                      child: Center(
                                                        child: Text("to Cash"),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "TO_BENEFICIARY",
                                                      child: Center(
                                                        child: Text(
                                                            "to Recipient"),
                                                      ),
                                                    ),
                                                  ],
                                                  onChanged: (value) => {
                                                        setState(() {
                                                          transferType =
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
                              showTransferFields(),
                              SizedBox(
                                height: 20,
                              ),
                              //CHARGES Type------------------------------------
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
                                        0: FractionColumnWidth(0.4)
                                      },
                                      children: [
                                        TableRow(children: [
                                          Center(
                                            child: Text(
                                              'Charges',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<Object>(
                                                isExpanded: true,
                                                value: chargesType,
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "FROM_ME",
                                                    child: Center(
                                                      child: Text("I will Pay"),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "FROM_OTHER",
                                                    child: Center(
                                                      child: Text("From him"),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "FROM_BOTH",
                                                    child: Center(
                                                      child: Text("Split it"),
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (value) => {
                                                      setState(() {
                                                        chargesType =
                                                            value.toString();
                                                      }),
                                                    }),
                                          ),
                                        ]),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              showBeneficiarySelection(),
                              SizedBox(
                                height: 20,
                              ),
                              //Balance ----------------------------------------
                              TextFormField(
                                controller: balanceController,
                                enabled: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText: 'Balance',
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: Icon(
                                      Icons.money_rounded,
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
                                "Transfer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () => {
                            LoginLoading.showLoaderDialog(context),
                            setState(() {
                              transferType != "TO_BENEFICIARY"
                                  ? _transferService.makeTransfer({
                                      "accountFrom": accountFrom,
                                      "amount": balanceController.text,
                                      "accountTo": accountNumberController.text,
                                      "transferType": transferType,
                                      "costType": chargesType,
                                      "recipientEmail":
                                          recipientEmailController.text,
                                    }).then((value) => {
                                        isClicked = value,
                                        Navigator.pop(context),
                                        MyAlert()
                                            .getAlert(
                                                context,
                                                value
                                                    ? "Transfer Registered Successfuly"
                                                    : "Transfer Failed",
                                                value)
                                            .show()
                                      })
                                  : transferNumberType == "TO_ONE"
                                      ? _transferService
                                          .makeTransferToRecipient({
                                          "accountFrom": accountFrom,
                                          "amount": balanceController.text,
                                          "costType": chargesType,
                                          "selectedRecipient": selectedRecipient
                                        }).then((value) => {
                                                isClicked = value,
                                                Navigator.pop(context),
                                                MyAlert()
                                                    .getAlert(
                                                        context,
                                                        value
                                                            ? "Transfer Registered Successfuly"
                                                            : "Transfer Failed",
                                                        value)
                                                    .show()
                                              })
                                      : _transferService.makeTransferToGroup({
                                          "accountFrom": accountFrom,
                                          "amount": balanceController.text,
                                          "recipients": recipients,
                                          "selectedGroup": groupName,
                                          "costType": chargesType
                                        }).then((value) => {
                                            isClicked = value,
                                            Navigator.pop(context),
                                            MyAlert()
                                                .getAlert(
                                                    context,
                                                    value
                                                        ? "Transfer Registered Successfuly"
                                                        : "Transfer Failed",
                                                    value)
                                                .show()
                                          });
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

  void fillUserAccounts(String s) {
    _accountsService
        .getAccountsOfClient(s)
        .then((value) => _userAccounts = value);
  }

  Widget showTransferFields() {
    switch (transferType) {
      case "TO_ACCOUNT":
        transferNumberType = "";
        return TextFormField(
          controller: accountNumberController,
          enabled: true,
          decoration: InputDecoration(
              labelText: 'Account Number',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
              prefixIcon: Icon(
                Icons.account_balance_wallet,
                color: Colors.cyan,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRad,
                borderSide: cyanBorderside,
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
        );
      case "TO_CASH":
        transferNumberType = "";
        return Column(
          children: [
            TextFormField(
              controller: accountNumberController,
              enabled: true,
              decoration: InputDecoration(
                  labelText: 'Beneficiary CIN',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.cyan,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRad,
                    borderSide: cyanBorderside,
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
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: recipientEmailController,
              enabled: true,
              decoration: InputDecoration(
                  labelText: 'Beneficiary Email or phone',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.cyan,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRad,
                    borderSide: cyanBorderside,
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
        );
      case "TO_BENEFICIARY":
        return Container(
          height: 58,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan),
            borderRadius: borderRad,
          ),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FractionColumnWidth(0.4)
                },
                children: [
                  TableRow(children: [
                    Center(
                      child: Text(
                        'To Who ?',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Object>(
                          isExpanded: true,
                          value: transferNumberType,
                          items: [
                            DropdownMenuItem(
                              value: "",
                              child: Center(
                                child: Text("Select One"),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "TO_ONE",
                              child: Center(
                                child: Text("To One"),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "TO_GROUP",
                              child: Center(
                                child: Text("To Group"),
                              ),
                            ),
                          ],
                          onChanged: (value) => {
                                setState(() {
                                  transferNumberType = value.toString();
                                }),
                              }),
                    ),
                  ]),
                ]),
          ),
        );
    }
    return SizedBox();
  }

  Widget showBeneficiarySelection() {
    switch (transferNumberType) {
      case "TO_ONE":
        return Container(
          height: 58,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan),
            borderRadius: borderRad,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FractionColumnWidth(0.4)
                },
                children: [
                  TableRow(children: [
                    Center(
                        child: Text(
                      'Recipients',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Object>(
                          isExpanded: true,
                          value: selectedRecipient,
                          items: recipients!
                              .map(
                                (recipient) => DropdownMenuItem(
                                  value: recipient,
                                  child: Center(
                                    child: Text(recipient.name.toString()),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => {
                                setState(() {
                                  selectedRecipient = value as Recipient?;
                                }),
                              }),
                    ),
                  ]),
                ]),
          ),
        );

      case "TO_GROUP":
        return Container(
          height: 58,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan),
            borderRadius: borderRad,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FractionColumnWidth(0.3)
                },
                children: [
                  TableRow(children: [
                    Center(
                        child: Text(
                      'Existing Groups',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Object>(
                          isExpanded: true,
                          value: groupName,
                          items: _clientService
                              .recipientsGroups(recipients)
                              .map(
                                (group) => DropdownMenuItem(
                                  value: group,
                                  child: Center(
                                    child: Text(group),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => {
                                setState(() {
                                  groupName = value.toString();
                                }),
                              }),
                    ),
                  ]),
                ]),
          ),
        );
    }
    return SizedBox();
  }
}
