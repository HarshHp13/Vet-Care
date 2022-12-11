import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/AddPet.dart';
import 'package:vetcare/screen/UserDetails(RegestrationForm).dart';
import 'package:vetcare/widgets/Large/PetListLarge.dart';
import 'package:vetcare/widgets/PetList.dart';
import 'package:vetcare/widgets/small/PetListSmall.dart';

class Userprofilebody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
          future: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.done){
              Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;

            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width / 5,
                            height: width / 5,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data['Name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => userdetails(
                                      data: data,
                                    ),
                                  ));
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${data['phonenumber']}",
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
                  child: Container(
                    padding: EdgeInsets.all(width / 20),
                    color: Color.fromRGBO(238, 244, 246, 1),
                    child: Column(
                      children: [
                        width < 1000
                            ? Expanded(child: PetList())
                            : Expanded(child: PetList()),
                        InkWell(
                          onTap: () {Navigator.of(context).pushNamed(AddPet.route);},
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
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator.adaptive(),);
          }
        );
      }
}
