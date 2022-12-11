import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/OTPScreen.dart';
import 'dart:math';

import 'package:vetcare/services/LoginAndSignUpService.dart';
import 'package:vetcare/widgets/OTPForm.dart';

enum AuthMode { Signup, Login }

class LoginAndSignUpFormSmall extends StatefulWidget {
  @override
  _LoginAndSignUpFormSmallState createState() =>
      _LoginAndSignUpFormSmallState();
}

class _LoginAndSignUpFormSmallState extends State<LoginAndSignUpFormSmall> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService.instance;
  AuthMode _authMode = AuthMode.Signup;
  bool _connecting = false;
  bool _state=false;
  String _phoneNumber = "";

  get onPressed => null;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        _state=false;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _state=true;
      });
    }
  }
  void _saveForm() async {
    setState(() {
      _connecting = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await _authenticationService.signInWithPhoneNumber(
            _phoneNumber, context);
        //var details = {'phone':_phoneNumber,'state':_state};
        Navigator.of(context).pushReplacementNamed(OTPScreen.route,arguments:{'phone':_phoneNumber,'state':_state});
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error Logging In")));
      }
    }
    setState(() {
      _connecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print((height - 0.46 * height - 100));
    /**
     * single child scroll view so that if very small screen then it can be
     * scrolled if needed
     */
    return SingleChildScrollView(
      // the white container to contain the form
      child: Container(
        margin: EdgeInsets.only(
          left: max((width - 400) / 2, 40),
          top: max((height - 0.46 * height - 100) / 2, 120),
          right: max((width - 400) / 2, 40),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 0.05 * height,
          horizontal: 0.06 * width,
        ),
        alignment: Alignment.center,
        width: width * 370.0 / 428.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        // content of the form
        child: Column(
          children: [
            /**
             * Intial of the content logo and text
             */
            Icon(
              Icons.pets,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text( _authMode == AuthMode.Login ? 'Login to VetCare' : 'Sign up to VetCare',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: min(width * 0.05, 20),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            /**
             * The form to enter Phone number
             */

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // phone number field

                  /*Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: min(0.02 * width, 13),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),*/
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length < 10) {
                        return "Not a valid number";
                      }
                      if (value.length > 10) {
                        return "Please do not add 0 or country code before the number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(209, 222, 224, 1),
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "Phone Number",
                    ),
                    onSaved: (value) {
                      _phoneNumber = "+91" + value;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Login Signup Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      minimumSize: Size(
                        width * 5 / 6 - 0.05 * width,
                        height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                        horizontal: width * 0.02,
                      ),
                    ),
                    onPressed: _connecting ? null : _saveForm,
                    child: Text(
                      _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                      style: TextStyle(
                        fontSize: min(width * 0.05, 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_authMode == AuthMode.Login ? 'Not a user yet?' : 'Already a user?'
                    ,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: min(width * 0.04, 15),

                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(

                      primary: Theme.of(context).primaryColor,
                      textStyle: TextStyle(fontSize: min(width * 0.04, 15),fontWeight: FontWeight.w600,),
                    ),
                    onPressed: _switchAuthMode,
                    child: Text(_authMode == AuthMode.Login ? 'Sign Up' : 'Login'),


                  ),
                ]
            ),
            /**
             * Button to signUp using google
             */
            TextButton(
              onPressed: _connecting
                  ? null
                  : () async {
                setState(() {
                  _connecting = true;
                });
                try {
                  await _authenticationService.signInWithGoogle();
                  // navigate to homePage
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.route);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error Loging In!"),
                    ),
                  );
                  setState(() {
                    _connecting = false;
                  });
                }
              },

              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(
                  vertical: min(height * 0.05, 20.5),
                  horizontal: min(width * 0.05, 0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.1),
                ),
              ),

              child: Text(
                "G",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: min(width * 0.07, 22),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}