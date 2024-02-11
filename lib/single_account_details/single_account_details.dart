import 'package:app_for_test/listCards/single_card_details.dart';
import 'package:app_for_test/models/Account.dart';
import 'package:app_for_test/services/card_service.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:app_for_test/models/Card.dart' as myCard;

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key, this.account, this.allAccount})
      : super(key: key);

  final Account? account;
  final List<Account>? allAccount;

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  Account? account;
  List<myCard.Card> cardList = List.empty(growable: true);

  CardService _cardService = new CardService();
  bool cardLoaded = false;

  @override
  void initState() {
    super.initState();
    account = widget.account;
    _cardService.getCardsOfAccount(account!.id).then((value) => {
          print(account!.id),
          setState(() {
            cardList = value;
            cardLoaded = true;
          }),
        });
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Details"),
        actions: [],
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topArea(),
            SizedBox(
              height: 40.0,
              child: Icon(
                Icons.refresh,
                size: 35.0,
                color: Colors.cyanAccent,
              ),
            ),
            horizntalCardsShow(),
            displayAccoutList(),
          ],
        ),
      ),
    );
  }

  Card topArea() => Card(
        margin: EdgeInsets.all(10.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    radius: 5.5, colors: [Colors.cyan, Color(0xFF015FFF)])),
            padding: EdgeInsets.all(5.0),
            // color: Color(0xFF015FFF),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          counter = (counter - 1) % widget.allAccount!.length;
                          account = widget.allAccount?.elementAt(counter);
                          cardLoaded = false;
                          _cardService
                              .getCardsOfAccount(account!.id)
                              .then((value) => {
                                    print(account!.id),
                                    setState(() {
                                      cardList = value;
                                      cardLoaded = true;
                                    }),
                                  });
                        });
                      },
                    ),
                    Text(account!.accountNumber.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          counter = (counter + 1) % widget.allAccount!.length;
                          account = widget.allAccount?.elementAt(counter);
                          cardLoaded = false;
                          _cardService
                              .getCardsOfAccount(account!.id)
                              .then((value) => {
                                    print(account!.id),
                                    setState(() {
                                      cardList = value;
                                      cardLoaded = true;
                                    }),
                                  });
                        });
                      },
                    )
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(r"$ " + account!.balance.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                  ),
                ),
                SizedBox(height: 35.0),
              ],
            )),
      );

  displayAccoutList() {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          accountItems("Trevello App", r"+ $ 4,946.00", "28-04-16", "credit",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 5,428.00", "26-04-16", "credit"),
        ],
      ),
    );
  }

  Widget horizntalCardsShow() {
    int _index = 0;
    return !cardLoaded
        ? SizedBox(
            height: 200, child: Center(child: CircularProgressIndicator()))
        : cardList.length == 0
            ? SizedBox(
                height: 200,
                child: Center(child: Text("There is no card to show")))
            : Center(
                child: SizedBox(
                  height: 200, // card height
                  child: PageView.builder(
                    itemCount: cardList.length,
                    controller: PageController(viewportFraction: 1),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: GestureDetector(
                          child: CreditCard(
                            horizontalMargin: 10,
                            cardNumber: cardList.elementAt(i).cardNumber,
                            cardExpiry: cardList.elementAt(i).dateExpiration,
                            cardHolderName:
                                cardList.elementAt(i).cardHolderName,
                            cvv: cardList.elementAt(i).csv.toString(),
                            bankName: "Our Bank",
                            cardType: cardList.elementAt(i).type == "MASTERCARD"
                                ? CardType.masterCard
                                : cardList.elementAt(i).type == "VISA"
                                    ? CardType.visa
                                    : CardType.dinersClub,
                            showBackSide: false,
                            frontBackground:
                                cardList.elementAt(i).type == "MASTERCARD"
                                    ? CardBackgrounds.black
                                    : cardList.elementAt(i).type == "VISA"
                                        ? CardBackgrounds.custom(0xff00838F)
                                        : CardBackgrounds.custom(0xFFFF6F00),
                            backBackground: CardBackgrounds.black,
                            showShadow: true,
                          ),
                          onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CardDetails(
                                  card: cardList.elementAt(i),
                                ),
                              ),
                            ),
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
  }

  Container accountItems(
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
        ),
      );
}
