import 'package:flutter/material.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/widgets/HamburgerMenu.dart';
import 'package:vetcare/widgets/TransactionsList.dart';

import 'UserProfile.dart';

class Transactions extends StatelessWidget {
  static String route = "/transaction";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: HamburgerMenu(),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomePage.route);
              },
              icon: Icon(Icons.pets),
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
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        width: width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(238, 244, 246, 1),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Transactions",
                style: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            TransactionsList(),
          ],
        ),
      ),
    );
  }
}
