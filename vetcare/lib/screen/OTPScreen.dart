import 'package:flutter/material.dart';
import 'package:vetcare/widgets/OTPForm.dart';
import 'package:vetcare/widgets/small/LoginAndSignUpFormSmall.dart';
import 'package:vetcare/widgets/Large/LoginAndSignUpFormLarge.dart';

class OTPScreen extends StatelessWidget {
  static String route = "/otp";
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    //AuthMode _authMode=ModalRoute.of(context).settings.arguments;
    //bool state=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: OTPForm(args['phone'],args['state']),
    );
  }
}