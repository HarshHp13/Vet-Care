import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/OTPScreen.dart';
import 'dart:math';
import 'package:vetcare/services/LoginAndSignUpService.dart';

import '../OTPForm.dart';

enum AuthMode { Signup, Login }
class LoginAndSignUpFormLarge extends StatefulWidget {
  @override
  _LoginAndSignUpFormLargeState createState() =>
      _LoginAndSignUpFormLargeState();
}

class _LoginAndSignUpFormLargeState extends State<LoginAndSignUpFormLarge> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService.instance;
  bool _connecting = false;
  bool _state=false;
  AuthMode _authMode = AuthMode.Signup;
  String _phoneNumber = "";
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double right = min(width * 0.1, 200);
    print(right);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/form_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: max((height - 500) / 2, 120),
            right: right,
            left: width - right - 400,
            // bottom: max((height - 500) / 2, 120),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 60,
          ),
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
              const SizedBox(
                height: 5,
              ),
              Text(
                _authMode == AuthMode.Login ? 'Login to VetCare' : 'Sign up to VetCare',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: min(width * 0.05, 20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 24,
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
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        _phoneNumber = "+91" + value;
                      },
                    ),
                    const SizedBox(
                      height: 12,
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
              const SizedBox(
                height: 20,
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
                ],),
              const SizedBox(
                height: 20,
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
                      vertical: min(height * 0.05, 23),
                      horizontal: min(width * 0.05, 18)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5000),
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
              )
            ],
          ),
        ),
      ),

    );
  }
}