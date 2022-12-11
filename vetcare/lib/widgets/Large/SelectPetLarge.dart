import 'package:flutter/material.dart';
import 'package:vetcare/widgets/Large/PetListLarge.dart';
import 'package:vetcare/widgets/PetList.dart';

class SelectPetLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
