import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app_for_test/ListRecipients/list_Recipients.dart';
import 'package:app_for_test/agencies/show_agency.dart';
import 'package:app_for_test/listAccounts/list_accounts.dart';
import 'package:app_for_test/listCards/list_cards.dart';
import 'package:app_for_test/list_transfers/list_transfers.dart';
import 'package:app_for_test/login_page/loginPage.dart';
import 'package:app_for_test/login_page/models/loginResponse.dart';
import 'package:app_for_test/makeTransfer/make_transfer.dart';
import 'package:app_for_test/messaging/chat_screen.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/profile_info/profile_page.dart';
import 'package:app_for_test/profile_info/themes.dart';
import 'package:app_for_test/services/client_service.dart';
import 'package:app_for_test/settingsPage/settings_page.dart';
import 'package:app_for_test/tos/tos_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.user}) : super(key: key);

  final LoginResponse user;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Client client;
  ClientService _clientService = new ClientService();

  @override
  void initState() {
    super.initState();
    _clientService.getClientInfo(widget.user.id).then((value) => {
          setState(() {
            client = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var drawer = Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            child: UserAccountsDrawerHeader(
              accountName: Text(widget.user.username.toString()),
              accountEmail: Text(widget.user.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    image: AssetImage("images/user-profile.png"),
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/profile-bg3.jpg')),
              ),
            ),
            onTap: _onProfileTap,
          ),
          ListTile(
            leading: Icon(Icons.assistant_outlined),
            title: Text('Accounts'),
            onTap: _onAccountsTap,
          ),
          ListTile(
            leading: Icon(Icons.credit_card_rounded),
            title: Text('Cards'),
            onTap: _onCardsTap,
          ),
          ListTile(
            leading: Icon(Icons.price_change_outlined),
            title: Text('Recipients'),
            onTap: _onRecipientsTap,
          ),
          ListTile(
            leading: Icon(Icons.explicit_outlined),
            title: Text('Transfers'),
            onTap: _onTransfersTap,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TOSPage(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginPage()),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      drawer: drawer,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        toolbarHeight: 50,
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 280,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/ebanking-women.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            height: 180,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        // width: 180,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(
                                color: Colors.orangeAccent, width: 0.5),
                          ),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Text('Payement',
                                    style: TextStyle(color: Colors.deepOrange)),
                                subtitle: ImageIcon(
                                    AssetImage("images/payementIcon.png"),
                                    color: Colors.orangeAccent,
                                    size: 50),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        // width: 180,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(
                                color: Colors.cyanAccent, width: 0.5),
                          ),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: ImageIcon(
                                    AssetImage("images/transferIcon.png"),
                                    color: Colors.cyan,
                                    size: 50),
                                subtitle: Text(
                                  'Transfer',
                                  style: TextStyle(color: Colors.cyan),
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MakeTransfer(userId: widget.user.id),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        // width: 180,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(
                                color: Colors.cyanAccent, width: 0.5),
                          ),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text('Switch',
                                    style: TextStyle(color: Colors.cyan)),
                                subtitle: ImageIcon(
                                    AssetImage("images/bankIcon.png"),
                                    color: Colors.cyan,
                                    size: 50),
                                onTap: () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ShowAgency(),
                                    ),
                                  )
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        // width: 180,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(
                                color: Colors.orangeAccent, width: 0.5),
                          ),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: ImageIcon(
                                    AssetImage("images/profileIcon.png"),
                                    color: Colors.orangeAccent,
                                    size: 45),
                                subtitle: Text('Profile',
                                    style: TextStyle(color: Colors.deepOrange)),
                                onTap: _onProfileTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: isDarkMode ? Colors.transparent : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: ImageIcon(
                            AssetImage("images/complainIcon.png"),
                            color: Colors.deepOrange,
                            size: 50),
                        subtitle: Text('Post Help',
                            style: TextStyle(color: Colors.orange)),
                        onTap: _onChatTap,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyanAccent),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: isDarkMode ? Colors.transparent : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: ImageIcon(AssetImage("images/callCenter.png"),
                            color: Colors.cyanAccent, size: 50),
                        subtitle: Text('Need Help',
                            style: TextStyle(color: Colors.cyan)),
                        onTap: _onChatTap,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onAccountsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ListAccount(
                client: client,
              )),
    );
  }

  void _onCardsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ListCards(
                client: client,
              )),
    );
  }

  void _onRecipientsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ListRecipients(client: client)),
    );
  }

  void _onTransfersTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListTransfers(
          client: client,
        ),
      ),
    );
  }

  void _onChatTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  void _onProfileTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ThemeProvider(
          initTheme: MyThemes.lightTheme,
          child: Builder(
            builder: (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              //theme: ThemeProvider.of(context),
              title: "Profile",
              home: ProfilePage(
                client: client,
              ),
            ),
          ),
        );
      }),
    );
  }
}
