import 'package:flutter/material.dart';

Widget drawerHeader(String name, bool danger) {
  return Container(
    height: 180,
    child: DrawerHeader(
      decoration: BoxDecoration(
          image: danger
              ? DecorationImage(
                  image: AssetImage('images/danger.jpg'), fit: BoxFit.cover)
              : DecorationImage(
                  image: AssetImage('images/smarthousebackground.jpg'),
                  fit: BoxFit.cover)),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: name.length >= 12 ? 75.00 : 85.00,
            child: Text(
              'Welcome,\n $name',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget listTile(var context, Icon icon, String label, String path,
    {String? args, var danger}) {
  if (danger == null) {
    danger = false;
  }
  return ListTile(
    title: TextButton(
      onPressed: () {
        if (path == 'Appareils_EC') /*goToDevices(args, context);*/
        if (path == '/Authenticate') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are You Sure ?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'Oui',
                        style: TextStyle(
                            color:
                                danger ? Colors.red[700] : Color(0xff3c56f5)),
                      ),
                      onPressed: () async {
                        /*await AuthService().signOUT();*/
                        Navigator.pushNamedAndRemoveUntil(context,
                            '/Authenticate', (Route<dynamic> route) => false);
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Non',
                        style: TextStyle(
                            color:
                                danger ? Colors.red[700] : Color(0xff3c56f5)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        } else if (path != 'Manage_Services-from_Admin' &&
            path != '/Manage_Confined_Spaces_from_Admin' &&
            path != '/Manage_Confined_Spaces_from_AdminDel' &&
            path != 'Appareils_EC')
          Navigator.pushNamed(context, path, arguments: args);
      },
      child: Row(
        children: <Widget>[
          icon,
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                '$label',
                style: TextStyle(
                    color: Color(0xff2d27ad), fontWeight: FontWeight.bold),
              ))
        ],
      ),
    ),
  );
}

/*void goToDevices(String user, var context) async {
  if (user.profile == 'Superviseur' || user.profile == 'Utilisateur normal') {
    String espasconfineid;
    await DatabaseServices()
        .userscollection
        .document(user.uid)
        .get()
        .then((doc) {
      espasconfineid = doc['espaceConfineId'];
    });
    if (espasconfineid != null) {
      Navigator.pushNamed(context, '/ConnectedDevices',
          arguments: [espasconfineid, user.uid]);
    } else {
      showdialog(context, 'Alert !', Text('You Don\'t Have Spaces '), actions: [
        TextButton(
          child: Text('ok', style: TextStyle(color: ocpColor)),
          onPressed: () => Navigator.pop(context),
        )
      ]);
    }
  }
  Navigator.pushNamed(context, '/ConnectedDevices');
}*/
