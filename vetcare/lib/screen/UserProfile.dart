import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/AddPet.dart';
import 'package:vetcare/widgets/HamburgerMenu.dart';
import 'package:vetcare/widgets/Large/PetListLarge.dart';
import 'package:vetcare/widgets/PetList.dart';
import 'package:vetcare/widgets/small/PetListSmall.dart';
import 'package:vetcare/widgets/small/userprofilebody.dart';

class UserProfile extends StatelessWidget {
  static String route = "/user";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return width > 1000
              ? Scaffold(
                  floatingActionButton: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 40),
                    // margin: EdgeInsets.only(left: 1100),
                    height: 70,
                    width: 350,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AddPet.route);
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AddPet.route);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(225, 229, 234, 1),
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                child: Icon(Icons.pets),
                              ),
                              title: Center(
                                child: Text(
                                  'Add Pet',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width / 10,
                                    height: width / 10,
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
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
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    data['Name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    data['phonenumber'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Quicksand",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            // color: Color.fromRGBO(238, 244, 246, 1),
                            child: PetList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  drawer: Drawer(
                    child: HamburgerMenu(),
                  ),
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pets,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Vet Care",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: islandscape
                      ? SingleChildScrollView(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Userprofilebody()),
                        )
                      : Userprofilebody());
        }
        return Center(child: CircularProgressIndicator.adaptive(),);
      },
      future: FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get(),
    );

  }
}
