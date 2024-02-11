import 'dart:convert';

import 'package:app_for_test/agencies/show_agency.dart';
import 'package:app_for_test/login_page/loginPage.dart';
import 'package:app_for_test/services/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:app_for_test/shared/Constants.dart' as constants;

// ignore: must_be_immutable
class ContinueRegistration extends StatefulWidget {
  late String username;

  ContinueRegistration({required this.username});

  @override
  _ContinueRegistrationState createState() => _ContinueRegistrationState();
}

class _ContinueRegistrationState extends State<ContinueRegistration> {
  var borderRad = BorderRadius.circular(15.0);
  var borderside = BorderSide(
    color: Color(0xffA4E8E0),
  );

  String? userId = "";
  String? firstname;
  String? lastname;
  String? phone;
  String? cin;
  String? address;
  String? birthday;
  String? agency;

  bool err = false;
  String? errMsg;

  final formkey = GlobalKey<FormState>();

  bool loading = false;

  List agenciesItemsList = List.filled(0, String, growable: true);

  final dateController = TextEditingController();

  String? agencyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffffff),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: StreamBuilder(builder: (context, snap) {
                    return Form(
                      key: formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset('images/appLogo.png', height: 110),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Continue Registration',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FutureBuilder(
                                future: getUsername(),
                                builder: (context, snap) {
                                  final usernameController =
                                      TextEditingController();
                                  usernameController.text =
                                      snap.data.toString();
                                  return TextFormField(
                                    controller: usernameController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        labelText: 'Username',
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Color(0xffA4E8E0),
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
                                    onSaved: (String? val) {},
                                    validator: (String? val) {
                                      if (val.toString().isEmpty) {
                                        return 'This Field Cannot be empty';
                                      } else {
                                        if (val.toString().length < 4)
                                          return 'Must be >= 4 character long';
                                        else {
                                          return null;
                                        }
                                      }
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            StreamBuilder(builder: (context, snap) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'First name',
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xffA4E8E0),
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
                                onSaved: (String? val) {
                                  firstname = val;
                                },
                                validator: (String? val) {
                                  if (val.toString().isEmpty) {
                                    return 'This Field Cannot be empty';
                                  } else {
                                    if (val.toString().length < 4)
                                      return 'Must be >= 4 character long';
                                    else {
                                      return null;
                                    }
                                  }
                                },
                              );
                            }),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Last name',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  prefixIcon: Icon(
                                    Icons.list,
                                    color: Color(0xffA4E8E0),
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
                              onSaved: (String? val) {
                                lastname = val;
                              },
                              validator: (String? val) {
                                if (val.toString().isEmpty) {
                                  return 'This Field Cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Color(0xffA4E8E0),
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
                              onSaved: (String? val) {
                                address = val;
                              },
                              validator: (String? val) {
                                if (val.toString().isEmpty) {
                                  return 'This Field Cannot be empty';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              initialValue: "+212",
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Color(0xffA4E8E0),
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
                              onSaved: (String? val) {
                                phone = val;
                              },
                              validator: (String? val) {
                                if (val.toString().isEmpty) {
                                  return 'This Field Cannot be empty';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              enableInteractiveSelection: false,
                              decoration: InputDecoration(
                                  labelText: 'CIN',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xffA4E8E0),
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
                              onSaved: (String? val) {
                                cin = val;
                              },
                              validator: (String? val) {
                                if (val.toString().isEmpty) {
                                  return 'This Field Cannot be empty';
                                } else {
                                  if (val.toString().length < 8)
                                    return 'This Field Must Be >= 8 char long';
                                  else
                                    return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: dateController,
                              decoration: InputDecoration(
                                  labelText: 'Birthday',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Color(0xffA4E8E0),
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
                              onSaved: (String? val) {
                                birthday = val;
                              },
                              validator: (String? val) {
                                if (val.toString().isEmpty) {
                                  return 'This Field Cannot be empty';
                                } else {
                                  if (val.toString().length < 6)
                                    return 'This Field Should be  >= 6 char long';
                                  else
                                    return null;
                                }
                              },
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                                dateController.text =
                                    date.toString().substring(0, 10);
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 58,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffA4E8E0)),
                                        borderRadius: borderRad,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Center(
                                        child: Table(
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FractionColumnWidth(0.27)
                                            },
                                            children: [
                                              TableRow(children: [
                                                Center(
                                                    child: Text(
                                                  'Agency',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                )),
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton<Object>(
                                                      isExpanded: true,
                                                      value: agency,
                                                      items: agenciesItemsList
                                                          .map((agencyItem) {
                                                        return DropdownMenuItem(
                                                          value: agencyItem[
                                                              'name'],
                                                          child: Center(
                                                            child: Text(
                                                                agencyItem[
                                                                    'name']),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) => {
                                                            setState(() {
                                                              agency = value
                                                                  .toString();
                                                              for (var item
                                                                  in agenciesItemsList) {
                                                                if (item['name']
                                                                        .toString() ==
                                                                    agency
                                                                        .toString()) {
                                                                  agencyId = item[
                                                                          'id']
                                                                      .toString();
                                                                }
                                                              }
                                                            }),
                                                          }),
                                                ),
                                              ]),
                                            ]),
                                      )),
                                ),
                                Container(
                                  width: 30,
                                  child: IconButton(
                                    color: Colors.amber,
                                    iconSize: 30,
                                    onPressed: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ShowAgency(),
                                        ),
                                      )
                                    },
                                    icon: Icon(Icons.location_on_outlined),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              err ? errMsg.toString() : '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: err ? 15 : 0,
                            ),
                            !loading
                                ? Material(
                                    borderRadius: borderRad,
                                    color: Color(0xffA4E8E0),
                                    child: MaterialButton(
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        var form = formkey.currentState;
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        if (form!.validate()) {
                                          form.save();
                                          setState(() {
                                            loading = true;
                                          });
                                          setState(() {
                                            err = false;
                                            errMsg = '';
                                          });
                                          //Here Where you need to create your user and save the data
                                          saveInformations();
                                        }
                                      },
                                    ),
                                  )
                                : SpinKitDualRing(
                                    color: Color(0xff33862c),
                                    size: 40.0,
                                    lineWidth: 4,
                                  ),
                            Center(
                                child: TextButton(
                              child: Text(
                                  !loading ? 'Return Home ?' : 'Loading...'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                          ]),
                    );
                  })),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getUsername() async {
    return await SecureStorage.readSecureData("username").then((value) {
      return value.toString();
    });
  }

  Future getAllAgencies() async {
    var response = await http.get(Uri.parse(constants.GET_ALL_AGENCIES_URL));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(
        () {
          agenciesItemsList = jsonData;
        },
      );
    }

    return await SecureStorage.readSecureData("username").then((value) {
      print(value.toString());
      return value.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getAllAgencies();
  }

  void saveInformations() async {
    var payload = json.encode({
      "id": userId,
      "username": widget.username,
      "firstname": firstname,
      "lastname": lastname,
      "phone": phone,
      "address": address,
      "cin": cin,
      "birthday": birthday,
      "agency": agencyId,
    });

    print("payload : ");
    print(payload);

    var response = await http.put(
      Uri.parse(constants.SAVE_USER_INFO_URL),
      headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'},
      body: payload,
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });

      var alertStyle = AlertStyle(
        animationType: AnimationType.fromBottom,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.green,
        ),
        alertAlignment: Alignment.center,
      );
      Alert(
        style: alertStyle,
        context: context,
        title: "Success",
        desc: "Account Created",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
            },
            width: 120,
          )
        ],
      ).show();
    }
  }
}
