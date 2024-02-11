import 'package:app_for_test/listAccounts/item_view.dart';
import 'package:app_for_test/models/Account.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/requestAccount/RequestNewAccount.dart';
import 'package:app_for_test/services/account_service.dart';
import 'package:app_for_test/single_account_details/single_account_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListAccount extends StatefulWidget {
  ListAccount({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  _ListAccountState createState() => new _ListAccountState();
}

class _ListAccountState extends State<ListAccount> {
  AccountService _accountsService = new AccountService();

  List<Account> clientAccounts = List.empty(growable: true);
  bool accountsLoaded = false;

  @override
  void initState() {
    super.initState();
    _accountsService.getAccountsOfClient(widget.client.id).then((value) {
      setState(() {
        clientAccounts = value;
        accountsLoaded = true;
        print(
            clientAccounts.length.toString() + "Accounts loaded successfully");
      });
    });
  }

  void _onRefresh() async {
    await _accountsService.getAccountsOfClient(widget.client.id).then((value) {
      setState(() {
        clientAccounts = value;
        accountsLoaded = true;
        print(
            clientAccounts.length.toString() + "Accounts loaded successfully");
        _refreshController.refreshCompleted();
      });
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.cyan,
        title: new Text("Your Accounts"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          Container(
            color: Colors.white54,
            child: IconButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        RequestNewAccount(client: widget.client)),
              ),
              icon: Icon(Icons.add_box),
            ),
          ),
        ],
      ),
      body: !accountsLoaded
          ? SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : clientAccounts.length == 0
              ? SizedBox(
                  height: 200,
                  child: Center(child: Text("There is no Accounts to show")))
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  header: WaterDropHeader(
                    waterDropColor: Colors.cyan,
                  ),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = Text("release to load more");
                      } else {
                        body = Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  child: new ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: clientAccounts.length,
                    itemBuilder: (context, index) {
                      var account = new Account();
                      if (clientAccounts.isNotEmpty) {
                        account = clientAccounts[index];
                      }
                      return GestureDetector(
                        child: new Card(
                          color: Theme.of(context).cardColor,
                          //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10.0),
                                top: Radius.circular(2.0)),
                          ),
                          child: new ItemView(
                              account.id.toString(),
                              account.accountNumber.toString(),
                              account.balance.toString(),
                              account.currency.toString(),
                              DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(
                                  account.creationDate.toString(),
                                ),
                              ),
                              account.creationTime.toString(),
                              account.type.toString()),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AccountDetails(
                                  account: account, allAccount: clientAccounts),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
