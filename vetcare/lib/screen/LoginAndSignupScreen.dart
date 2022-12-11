import 'package:flutter/material.dart';
import 'package:vetcare/widgets/Large/LoginAndSignUpFormLarge.dart';
import 'package:vetcare/widgets/small/LoginAndSignUpFormSmall.dart';

class LoginAndSignUp extends StatelessWidget {
  static String route = "/login";
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
            ? LoginAndSignUpFormSmall()
            : Expanded(child: LoginAndSignUpFormLarge()),
      ),
    );
  }
}
