import 'package:flutter/material.dart';
import 'package:vetcare/widgets/HamburgerMenu.dart';
import 'package:vetcare/widgets/Large/HomePageLarge.dart';
import 'package:vetcare/widgets/small/HomePageSmall.dart';

import 'UserProfile.dart';

class HomePage extends StatelessWidget {
  static String route = "/homepage";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Vet Care",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(UserProfile.route);
            },
            icon: Icon(Icons.person),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: Drawer(
        child: HamburgerMenu(),
      ),
      body: width < 1000 ? HomePageSmall() : HomePageLarge(),
    );
  }
}
