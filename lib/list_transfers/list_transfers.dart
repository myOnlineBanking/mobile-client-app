import 'package:app_for_test/list_transfers/transfer_details.dart';
import 'package:app_for_test/makeTransfer/make_transfer.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/models/Transfer.dart';
import 'package:app_for_test/services/transfer_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListTransfers extends StatefulWidget {
  ListTransfers({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;
  final String title = "List Transfers";

  @override
  _ListTransfersState createState() => _ListTransfersState();
}

class _ListTransfersState extends State<ListTransfers> {
  List<Transfer>? transfers;
  bool transfersLoaded = false;
  TransferService _transferService = TransferService();

  @override
  void initState() {
    super.initState();
    _transferService.getTransfersOfClient(widget.client.id).then((value) => {
          setState(() {
            print(value);
            transfers = value;
            transfersLoaded = true;
          }),
        });
  }

  void _onRefresh() async {
    await _transferService
        .getTransfersOfClient(widget.client.id)
        .then((value) => {
              setState(() {
                print(value);
                transfers = value;
                transfersLoaded = true;
              }),
            });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Transfer transfer) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.5, color: Colors.cyan.shade100),
              ),
            ),
            child: Text(
              "\$" + transfer.balance.toString(),
              style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            DateFormat('yyyy-MM-dd').format(
              DateTime.parse(
                transfer.creationDate.toString(),
              ),
            ),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Text(
                transfer.accountFrom.toString(),
                style: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              ),
              Container(
                // tag: 'hero',
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                ),
              ),
              Text(
                transfer.accountTo.toString(),
                style: TextStyle(
                    color: Colors.grey.shade400, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.cyan, size: 40.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransferDetails(transfer: transfer),
              ),
            );
          },
        );

    Card makeCard(Transfer transfer) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white70),
            child: makeListTile(transfer),
          ),
        );

    final makeBody = transfersLoaded
        ? Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SmartRefresher(
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
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: transfers!.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(transfers![index]);
                },
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box_outlined, color: Colors.cyan),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MakeTransfer(userId: widget.client.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.cyan,
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}
