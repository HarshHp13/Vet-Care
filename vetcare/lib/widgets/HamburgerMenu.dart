import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/AllChats.dart';
import 'package:vetcare/screen/ChatScreen.dart';
import 'package:vetcare/screen/Help.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/LoginAndSignupScreen.dart';
import 'package:vetcare/screen/SelectDoctor.dart';
import 'package:vetcare/screen/SelectPet.dart';
import 'package:vetcare/screen/Transaction.dart';
import 'package:vetcare/screen/UserProfile.dart';


class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data= snapshot.data.data() as Map<String, dynamic>;
          return Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Material(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ListTile(
                            title: Column(
                              children: [
                                Container(
                                  // width: ,
                                  // height: width / 10,
                                  // padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    // color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(4000),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                      )
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: data['image']!= null? NetworkImage(data['image']) : AssetImage('assets/images/user_profile.png'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    // Image.network('${_url}'),
                                    // Icon(
                                    //   Icons.account_circle,
                                    //   size: 50,
                                    // ),
                                    // NetworkImage('${_init.ref('$_path/profilepic.jpg').getDownloadURL()}'),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  data['Name'],
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            // trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(UserProfile.route);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //HomePage
                          ListTile(
                            leading: Icon(Icons.home),
                            title: Text('Home Page'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context).pushNamed(HomePage.route);
                            },
                          ),

                          //AllChats
                          ListTile(
                            leading: Icon(Icons.chat_outlined),
                            title: Text('All Chats'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context).pushNamed(AllChats.route);
                            },
                          ),

                          //SelectPet
                          ListTile(
                            leading: Icon(Icons.pets_outlined),
                            title: Text('Select Pet'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context).pushNamed(SelectPet.route);
                            },
                          ),

                          //SelectDoctor
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Select Doctor'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SelectDoctor.route);
                            },
                          ),

                          //Transaction
                          ListTile(
                            leading: Icon(Icons.payment_outlined),
                            title: Text('Transactions'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Transactions.route);
                            },
                          ),

                          ListTile(
                            leading: Icon(Icons.chat_outlined),
                            title: Text('ChatScreen'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context).pushNamed(ChatScreen.route);
                            },
                          ),
                          //UserProfile
                        ],
                      ),
                      ListTile(
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(Help.route);
                                },
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 40, 0),
                                    child: Row(children: [
                                      Icon(
                                        Icons.help_outline,
                                        color: Colors.black45,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Help',
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ]))),
                            Container(
                              width: 2,
                              height: 20,
                              color: Colors.black26,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(LoginAndSignUp.route);
                                  FirebaseAuth.instance.signOut();
                                },
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(40, 0, 10, 0),
                                    child: Row(children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.black45,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Log Out',
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ]))),
                          ],
                        ),
                      ),
                    ]),
              ),
            );
        }
        return SizedBox.shrink();
        });

  }
}