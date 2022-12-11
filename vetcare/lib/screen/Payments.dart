import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vetcare/screen/AllChats.dart';
import 'package:vetcare/screen/SelectDoctor.dart';
import 'package:vetcare/services/database.dart';
import 'package:vetcare/widgets/HamburgerMenu.dart';
// import 'package:vetcare/widgets/Large/PaymentsWeb.dart';
import 'package:vetcare/widgets/small/PaymentsIO.dart' if(dart.library.js) 'package:vetcare/widgets/Large/PaymentsWeb.dart';

import '../widgets/Large/AddPetLarge.dart';
import '../widgets/small/AddPetSmall.dart';
class Payments extends StatelessWidget {
  static String route = "/payment";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context).settings.arguments as Map;
    return MaterialApp(
      home: Builder(
        builder:(context)=>Scaffold(
          body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await Payment(name: args['name'],price:int.parse(args['charge']), image: args['image'], description: args['specialty'], docId: args['docId']);
                  if(args['payment']){
                    Navigator.of(context).pushNamed(AllChats.route);
                  }else{
                    Navigator.of(context).pushNamed(SelectDoctor.route);
                  }
                },
                child: Text('pay'),
              )
          ),
        ),
      ),
    );
  }
}