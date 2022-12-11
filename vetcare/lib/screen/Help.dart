import 'package:flutter/material.dart';
import 'package:vetcare/widgets/small/Helpsmall.dart';
import 'package:vetcare/widgets/Large/Helplarge.dart';

class Help extends StatelessWidget {
  static String route = "/help";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
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
        ),
        body: width < 1000
            ? islandscape
                ? SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.35,
                        ),
                        child: Helpsmall()),
                  )
                : Helpsmall()
            : Helplarge());
  }
}
