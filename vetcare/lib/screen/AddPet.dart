import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/services/database.dart';
import 'package:vetcare/widgets/Large/AddPetLarge.dart';
import 'package:vetcare/widgets/small/AddPetSmall.dart';
import 'package:provider/provider.dart';
class AddPet extends StatelessWidget {
  const AddPet({this.data});
  final Map<String, dynamic> data;
  static String route = "/addPet";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(207, 198, 189, 1),
        ),
        child: (width < height || width < 1000 || height < 600)
            ? kIsWeb
            ? Provider<Database>(
            create: (context)=>Database(),
            child: AddPetLarge(data: data,)
        )
            : Provider<Database>(
            create: (context)=>Database(),
            child: AddPetSmall(data: data,)
        )
            : Provider<Database>(
            create: (context)=>Database(),
            child: AddPetLarge(data: data,)
        ),
      ),
    );
  }
}