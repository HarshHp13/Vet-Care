import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/OTPScreen.dart';

class AuthenticationService {
  static AuthenticationService instance = AuthenticationService();
  String _verificationId = "";
  ConfirmationResult _confirmationResult;
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    }
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (kIsWeb) {
      _confirmationResult = await auth.signInWithPhoneNumber(phoneNumber);
    } else {
      print("verifying phone number");
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
            Navigator.of(context).pushReplacementNamed(HomePage.route);
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationId, int resendToken) {
            _verificationId = verificationId;
            Navigator.of(context).pushReplacementNamed(OTPScreen.route);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _verificationId = verificationId;
          });
    }
  }

  Future<UserCredential> verifyOTP(String otp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (kIsWeb) {
      return await _confirmationResult.confirm(otp);
    }
    print("verifying otp");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);
    await auth.signInWithCredential(credential);
  }
}
