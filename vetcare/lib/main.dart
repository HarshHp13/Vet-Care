import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/AddPet.dart';
import 'package:vetcare/screen/AllChats.dart';
import 'package:vetcare/screen/ChatScreen.dart';
import 'package:vetcare/screen/Help.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/LoginAndSignupScreen.dart';
import 'package:vetcare/screen/OTPScreen.dart';
import 'package:vetcare/screen/Payments.dart';
import 'package:vetcare/screen/SelectDoctor.dart';
import 'package:vetcare/screen/SelectPet.dart';
import 'package:vetcare/screen/Transaction.dart';
import 'package:vetcare/screen/UserProfile.dart';
import 'package:vetcare/widgets/OTPForm.dart';
import 'package:vetcare/screen/UserDetails(RegestrationForm).dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Text("Error...!"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: Container(
              child: Text("Loading...!"),
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firebaseUser=FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vet Care',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(81, 218, 133, 1),
        accentColor: Color.fromRGBO(38, 50, 101, 1),
      ),

      home: firebaseUser !=null ? HomePage() : LoginAndSignUp(),

      routes: {
        LoginAndSignUp.route: (ctx) => LoginAndSignUp(),
        userdetails.route: (ctx) => userdetails(),
        HomePage.route: (ctx) => HomePage(),
        OTPScreen.route: (ctx) => OTPScreen(),
        UserProfile.route: (ctx) => UserProfile(),
        AllChats.route: (ctx) => AllChats(),
        ChatScreen.route: (ctx) => ChatScreen(),
        SelectPet.route: (ctx) => SelectPet(),
        SelectDoctor.route: (ctx) => SelectDoctor(),
        Help.route: (ctx) => Help(),
        Transactions.route: (ctx) => Transactions(),
        Payments.route: (ctx) => Payments(),
        AddPet.route: (ctx) => AddPet(),
      },
    );
  }
}
