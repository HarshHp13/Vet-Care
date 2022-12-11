import 'package:flutter/material.dart';
import 'package:vetcare/screen/AllChats.dart';
import 'package:vetcare/widgets/Large/ChatListItemLarge.dart';

import '../CategoryItem.dart';

class HomePageLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
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
                padding: const EdgeInsets.only(left: 50),
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
                height: width / 16 * 3.5,
                child: GridView(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 3,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  children: [
                    CategoryItem("assets/images/dog_category.jpg", "Dog",
                        width / 4 - 25),
                    CategoryItem("assets/images/cat_category.jpg", "Cat",
                        width / 4 - 25),
                    CategoryItem("assets/images/dairy_category.jpg", "Dairy",
                        width / 4 - 25),
                    CategoryItem("assets/images/other_category.jpg", "Other",
                        width / 4 - 25),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
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
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // ChatListItemLarge("Kavyansh Gangwar", "General Physician"),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // ChatListItemLarge("Kavyansh Gangwar", "General Physician"),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // ChatListItemLarge("Kavyansh Gangwar", "General Physician"),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // ChatListItemLarge("Kavyansh Gangwar", "General Physician"),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AllChats.route);
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
