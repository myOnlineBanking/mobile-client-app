import 'dart:ui';

import 'package:app_for_test/services/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'Profile_Drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final Color ocpColor = Color(0xfff7892b);
  static final Color backgroundColor = Colors.white;

  //final databaseReference = FirebaseDatabase.instance.reference();

  String temperatureValue = "0";
  String limunosityValue = "0";
  int doorValue = 1;
  int ventilationValue = 0;
  int ventilationRPM = 0;
  int light_1Value = 0;
  int light_2Value = 0;
  String gazValue = "0";
  String humidityValue = "0";

  @override
  Widget build(BuildContext context) {
    SecureStorage.readSecureData("jwt").then((value) =>
        print("loginResponse.accessToken Build : " + value.toString()));

    SecureStorage.readSecureData("username")
        .then((value) => print("username Build : " + value.toString()));

    return SafeArea(
      child:
          /* StreamProvider<DocumentSnapshot>.value(
        value:
            DatabaseServices().userscollection.document(user.uid).snapshots(),
        child:*/
          Container(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/smarthousebackground.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              child: AppBar(
                                title: Text("Welcome " + "user"),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                actions: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.settings),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/Edit_user',
                                          arguments: "user");
                                    },
                                    tooltip: 'Edit Account',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 150),
                        Center(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "My House",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    textBaseline: TextBaseline.ideographic),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            height: 40,
                            thickness: 2,
                            indent: 20,
                            endIndent: 260,
                            color: Colors.white60),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 5),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  ImageIcon(
                                    AssetImage('images/lighting.png'),
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    limunosityValue.toString() + ' Lux',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Row(
                                children: [
                                  ImageIcon(
                                    AssetImage('images/waterdrop.png'),
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    humidityValue.toString() + '%',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.thermostat_sharp,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    temperatureValue.toString() + " °C",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: [
                      //This One Contains  The Door Card
                      Center(
                        child: GestureDetector(
                          child: Card(
                            color:
                                (doorValue == 1) ? ocpColor : backgroundColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: (doorValue == 1)
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      (doorValue == 1)
                                          ? Icons.sensor_door_outlined
                                          : Icons.sensor_door,
                                      size: 50.0,
                                      color: (doorValue == 1)
                                          ? Colors.white
                                          : Color(0xff2d3a7f),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text("Main Door",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            if (doorValue == 1)
                              doorValue = 0;
                            else
                              doorValue = 1;

                            //updateDoorValue();

                            setState(() {});
                          },
                        ),
                      ),

                      //This One Contains  The Main Light Card
                      Center(
                        child: GestureDetector(
                          child: Card(
                            color: (light_1Value == 1 && light_2Value == 1)
                                ? ocpColor
                                : backgroundColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color:
                                      (light_1Value == 1 && light_2Value == 1)
                                          ? Colors.white
                                          : Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      (light_1Value == 1 && light_2Value == 1)
                                          ? Icons.lightbulb
                                          : Icons.lightbulb_outline,
                                      size: 50.0,
                                      color: (light_1Value == 1 &&
                                              light_2Value == 1)
                                          ? Colors.white
                                          : Color(0xff2d3a7f),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text("Main Light",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (light_1Value == 1) {
                              light_1Value = 0;
                              light_2Value = 0;
                            } else {
                              light_1Value = 1;
                              light_2Value = 1;
                            }

                            //updateLightValue();

                            setState(() {});
                          },
                        ),
                      ),

                      //This One is For Temperature
                      Center(
                        child: Card(
                          color: ocpColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ImageIcon(
                                    AssetImage('images/gaz.png'),
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(gazValue.toString() + " ppm",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          drawer:
              /*StreamBuilder<DocumentSnapshot>(
            stream: DatabaseServices()
                .userscollection
                .document(user.uid)
                .snapshots(),
            builder: (contxet, snapshot) {
              var active = true;
              return active
                  ?*/
              Drawer(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  /*snapshot.hasData
                                ? drawerHeader(snapshot.data['name'], false)
                                :*/
                  drawerHeader("username", false),
                  listTile(
                      context,
                      Icon(Icons.supervised_user_circle,
                          color: Color(0xff2d27ad)),
                      'Users',
                      '/Manage_userss',
                      args: "user"),
                  listTile(
                      context,
                      Icon(Icons.history, color: Color(0xff2d27ad)),
                      'History',
                      '/Manage_history',
                      args: "user"),
                  listTile(
                      context,
                      Icon(Icons.devices_other, color: Color(0xff2d27ad)),
                      'Connected Devices',
                      '/ConnectedDevices',
                      args: "user"),
                  listTile(
                      context,
                      Icon(Icons.camera_front_sharp, color: Color(0xff2d27ad)),
                      'Captured Images',
                      '/CapturedImages',
                      args: "user"),
                  listTile(
                    context,
                    Icon(Icons.send, color: Color(0xff2d27ad)),
                    'Send Alert',
                    '/sendAlert',
                  ),
                  Divider(),
                  listTile(
                    context,
                    Icon(
                      Icons.exit_to_app,
                      color: Color(0xff2d27ad),
                    ),
                    'Logout',
                    '/Authenticate',
                  ),
                ],
              ),
            ),
          ),
          //: Container();
        ),
      ),
      /*),*/
    );
  }

  /*void readData() {
    databaseReference.child("Temperature").once().then((DataSnapshot snapshot) {
      temperatureValue = snapshot.value;
    });
    databaseReference.child("Gaz").once().then((DataSnapshot snapshot) {
      gazValue = snapshot.value;
    });
    databaseReference.child("Luminosite").once().then((DataSnapshot snapshot) {
      limunosityValue = snapshot.value;
    });
    databaseReference.child("Door").once().then((DataSnapshot snapshot) {
      doorValue = snapshot.value;
    });
    databaseReference.child("Ventilation").once().then((DataSnapshot snapshot) {
      ventilationValue = snapshot.value;
    });
    databaseReference.child("Humidity2").once().then((DataSnapshot snapshot) {
      humidityValue = snapshot.value;
    });
    databaseReference
        .child("Light_room_1")
        .once()
        .then((DataSnapshot snapshot) {
      light_1Value = snapshot.value;
    });
    databaseReference
        .child("Light_room_2")
        .once()
        .then((DataSnapshot snapshot) {
      light_2Value = snapshot.value;
    });

    setState(() {
      temperatureValue = temperatureValue;
      limunosityValue = limunosityValue;
      gazValue = gazValue;
      doorValue = doorValue;
      ventilationValue = ventilationValue;
      light_1Value = light_1Value;
      light_2Value = light_2Value;
    });
  }

  void stopVentilation() {
    databaseReference.child("Ventilation").set(0);
  }

  void updateLightValue() {
    databaseReference.child("Light_room_1").set(light_1Value);
    databaseReference.child("Light_room_2").set(light_2Value);
  }

  void updateDoorValue() {
    databaseReference.child("Door").set(doorValue);
  }

  void startVentilation() {
    databaseReference.child("Ventilation").set(1);
  }
  */
}
