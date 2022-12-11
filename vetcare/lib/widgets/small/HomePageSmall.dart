import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/screen/AllChats.dart';
import 'package:vetcare/widgets/CategoryItem.dart';
import 'package:vetcare/widgets/Large/ChatListItemLarge.dart';
import 'package:vetcare/widgets/small/ChatListItem.dart';

class HomePageSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(238, 244, 246, 1),
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              Container(
                width: width,
                height: 3 * width / 4,
                child: GridView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: 200,
                    childAspectRatio: 4 / 5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: [
                    CategoryItem("assets/images/dog_category.jpg", "Dog",
                        width / 2 - 15),
                    CategoryItem("assets/images/cat_category.jpg", "Cat",
                        width / 2 - 15),
                    CategoryItem("assets/images/dairy_category.jpg", "Dairy",
                        width / 2 - 15),
                    CategoryItem("assets/images/other_category.jpg", "Other",
                        width / 2 - 15),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Recent Chats",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // ChatListItemSmall("Dr. Kavisha Gangwar", "General Physician"),
              // const SizedBox(
              //   height: 5,
              // ),
              // ChatListItemSmall("Kavyansh Gangwar", "General Physician"),
              // const SizedBox(
              //   height: 5,
              // ),
              // ChatListItemSmall("Kavyansh Gangwar", "General Physician"),
              // const SizedBox(
              //   height: 10,
              // ),
              Container(
                child: StreamBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // handle error
                    if (snapshot.hasError) {}
                    if (!snapshot.hasData) {
                      return SizedBox.shrink();
                    }
                    final chatDocs = snapshot.data.docs;
                    return ListView.builder(
                      itemCount: chatDocs.length,
                      itemBuilder: (ctx, index) => FutureBuilder(
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            Map<String, dynamic> data =
                            snapshot.data.data() as Map<String, dynamic>;
                            if(data["payment"]){
                              return ChatListItemSmall(
                                  data, chatDocs[index].reference.id
                              );
                            }else{
                              return SizedBox.shrink();
                            }
                          }
                          return SizedBox.shrink();
                        },
                        future: FirebaseFirestore.instance
                            .collection("doctors")
                            .doc(chatDocs[index].reference.id)
                            .get(),
                      ),
                    );
                  },
                  stream: FirebaseFirestore.instance
                      .collection("doctors")
                      .snapshots(),
                ),
              ),
              Center(
                  child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(AllChats.route);
                },
                icon: Text(
                  "All Chats",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                label: Icon(
                  Icons.arrow_right_alt,
                  color: Theme.of(context).accentColor,
                ),
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
