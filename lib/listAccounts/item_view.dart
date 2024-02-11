import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  final String accountId;
  final String accountNumber;
  final String balance;
  final String currency;
  final String creationDate;
  final String creationTime;

  final String reason;

  ItemView(this.accountId, this.accountNumber, this.balance, this.currency,
      this.creationDate, this.creationTime, this.reason);

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: nameCallMap(reason, currency, "Type"),
        ),
        new Expanded(
          child: new Padding(
            padding: EdgeInsets.all(5.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      expandStyle(3, widgetInquiryNo(accountNumber)),
                      SizedBox(
                        height: 30,
                      ),
                      expandStyle(2, widgetRs("\$", balance)),
                      expandStyle(2, widgetDateTime(creationDate)),
                    ]),
                widgetName("Currency"),
                widgetMobile(currency),
                SizedBox(
                  height: 8,
                ),
                widgetAddress("Type"),
                widgetReason(reason),
                widgetDeliveryType(creationTime)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

nameCallMap(String name, String currency, String address) => Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 21.0,
            child: new Text(
              name.substring(0, 1),
              style: new TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.grey.withOpacity(0.9)),
            ),
            backgroundColor: name == "NORMAL"
                ? Colors.green.withOpacity(0.2)
                : Colors.red.withOpacity(0.3),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 21.0,
            child:
                new Icon(Icons.monetization_on, color: Colors.orange.shade200),
            backgroundColor: Colors.transparent,
          ),
        ),
        GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 21.0,
              child: new Icon(Icons.disabled_by_default,
                  color: Colors.blue.shade200),
              backgroundColor: Colors.transparent,
            )),
      ],
    );

widgetInquiryNo(String accountNumber) => new Column(children: [
      new Text(
        accountNumber.contains(".")
            ? accountNumber.split(".")[0]
            : accountNumber,
        style: new TextStyle(
            fontFamily: 'Raleway', fontSize: 15.0, color: Colors.lightBlue),
      ),
      new Container(
        color: Colors.lightBlue,
        width: accountNumber.length <= 3 ? 7.0 * accountNumber.length : 21.0,
        height: 1.5,
      ),
    ], crossAxisAlignment: CrossAxisAlignment.start);

widgetDateTime(String dateTime) => new Text(
      dateTime.split(" ")[0],
      textAlign: TextAlign.right,
      style: new TextStyle(fontSize: 11.0, color: Colors.black26),
    );

widgetRs(String currency, String balance) => new Text(
      balance.isEmpty ? "" : currency + ". " + balance,
      textAlign: TextAlign.right,
      style: new TextStyle(fontSize: 14.0, color: Colors.black26),
    );

widgetName(String name) => new Container(
      margin: new EdgeInsetsDirectional.only(top: 10.0),
      child: Text(
        name,
        style: new TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 17.0,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );

widgetMobile(String currency) => new Text(
      "\$ - " + currency,
      style: new TextStyle(fontSize: 14.0, color: Colors.grey),
    );

widgetAddress(String address) => new Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        address,
        style: new TextStyle(fontSize: 15.0, color: Colors.black87),
      ),
    );

widgetReason(String reason) => reason.isEmpty
    ? Container()
    : new Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: Text(
          reason,
          style: new TextStyle(fontSize: 13, color: Colors.deepOrangeAccent),
        ),
      );

widgetDeliveryType(String deliveryType) => deliveryType.isEmpty
    ? Container()
    : new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(deliveryType, style: new TextStyle(fontSize: 12.0))
        ],
      );

buttonTextStyle(String btnName) =>
    new Text(btnName, style: new TextStyle(fontSize: 12.0));

expandStyle(int flex, Widget child) => Expanded(flex: flex, child: child);
