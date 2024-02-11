import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/profile_info/utils/user_preferences.dart';
import 'package:app_for_test/profile_info/widgets/appbar_widget.dart';
import 'package:app_for_test/profile_info/widgets/button_widget.dart';
import 'package:app_for_test/profile_info/widgets/profile_widget.dart';
import 'package:app_for_test/profile_info/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';

class EditProfilePage extends StatefulWidget {
  final Client client;

  const EditProfilePage({Key? key, required this.client}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController firstNameController = TextEditingController();

  final borderRad = BorderRadius.circular(15.0);

  final borderside = BorderSide(
    color: Color(0xffe46b10),
  );

  final cyanBorderside = BorderSide(
    color: Colors.cyan,
  );

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.client.firstname.toString();
  }

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath:
                      'https://hamzatahri.github.io/assets/img/profile-img.jpg',
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: firstNameController,
                  enabled: true,
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      // prefixIcon: Icon(
                      //   Icons.account_balance_wallet,
                      //   color: Colors.cyan,
                      // ),
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
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Last Name',
                  text: widget.client.lastname.toString(),
                  onChanged: (name) {},
                  enabled: false,
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: widget.client.email.toString(),
                  onChanged: (email) {},
                  enabled: false,
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Address',
                  text: widget.client.address.toString(),
                  onChanged: (about) {},
                  enabled: false,
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Phone',
                  text: widget.client.phone.toString(),
                  onChanged: (about) {},
                  enabled: false,
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'password',
                  text: "",
                  onChanged: (about) {},
                  enabled: true,
                ),
                const SizedBox(height: 24),
                buildSaveButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      );

  Widget buildSaveButton() => ButtonWidget(
        text: 'Save',
        onClicked: () {},
      );
}
