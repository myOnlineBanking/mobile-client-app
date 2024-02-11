import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/profile_info/widgets/appbar_widget.dart';
import 'package:app_for_test/profile_info/widgets/numbers_widget.dart';
import 'package:app_for_test/profile_info/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.client}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
  final Client client;
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath:
                    'https://hamzatahri.github.io/assets/img/profile-img.jpg',
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        client: widget.client,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              buildName(),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 48),
              buildAboutAgency(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            widget.client.firstname.toString().toUpperCase() +
                " " +
                widget.client.lastname.toString().toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            widget.client.email.toString(),
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            "Address " + widget.client.address.toString(),
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            "Phone Number: " + widget.client.phone.toString(),
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            "Agency: " + widget.client.cin.toString(),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildAboutAgency() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agency',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Name: " + "Agency Safi",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Address: " + "Safi Morocco",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Phone: " + "+2125102145",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
}
