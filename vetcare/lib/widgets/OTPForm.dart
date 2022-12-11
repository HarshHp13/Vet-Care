// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/UserProfile.dart';
import 'package:vetcare/screen/UserDetails(RegestrationForm).dart';
import 'package:vetcare/services/LoginAndSignUpService.dart';
import 'package:vetcare/widgets/small/LoginAndSignUpFormSmall.dart';
import '../screen/OTPScreen.dart';

//enum AuthMode { Signup, Login }
class OTPForm extends StatelessWidget {
  final phoneNumber;
  final bool state;
  OTPForm(this.phoneNumber,this.state);
  var otpController = TextEditingController();
  AuthenticationService authenticationService = AuthenticationService.instance;
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('user');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'AN OTP HAS BEEN SENT TO $phoneNumber',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(),
            width: MediaQuery.of(context).size.width * 0.4,
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'OTP',
                  hintText: 'Enter valid OTP'),
              controller: otpController,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' NOT RECEIVED OTP ?'),
              TextButton(
                  onPressed: () async {
                    await authenticationService.signInWithPhoneNumber(
                        phoneNumber, context);
                    Navigator.of(context).pushReplacementNamed(OTPScreen.route,
                        arguments: phoneNumber);
                  },
                  child: Text(
                    'RESEND OTP',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                try {
                  await authenticationService.verifyOTP(otpController.text);
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User user = auth.currentUser;
                  final uid = user.uid;
                  print(uid);
                  bool chk=await checkIfDocExists(uid.toString());

                  if(!chk)
                  {   //print("hello");
                    print(phoneNumber);
                    if(state) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("You are not registered...")));
                    }
                    // if(AuthMode.Login)
                    Navigator.of(context).pushReplacementNamed(userdetails.route,arguments: phoneNumber);}
                  else
                  { if(!state) ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("You are already registered...")));
                  Navigator.of(context).pushReplacementNamed(HomePage.route);}
                } catch (e) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                        title: Text(
                          "INVALID OTP",
                          textAlign: TextAlign.center,
                        ),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                                onPressed: () async {
                                  await authenticationService
                                      .signInWithPhoneNumber(
                                      phoneNumber, context);
                                  Navigator.of(context).pushReplacementNamed(
                                      OTPScreen.route,
                                      arguments: phoneNumber);
                                },
                                child: Text(
                                  'RESEND OTP',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'BACK',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                          ],
                        )),
                  );
                } finally {
                  otpController.clear();
                }
              },
              child: const Text(
                "SUBMIT",
              ))
        ],
      ),
    );
  }
}