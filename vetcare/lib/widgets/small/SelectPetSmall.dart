import 'package:flutter/material.dart';
import 'package:vetcare/widgets/PetList.dart';
import 'package:vetcare/widgets/small/PetListSmall.dart';

class SelectPetSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Select Pet",
            style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).accentColor,
              // backgroundColor: Color.fromRGBO(238, 244, 246, 1),
            ),
          ),
        ),
        PetList(),
      ],
    );
  }
}
