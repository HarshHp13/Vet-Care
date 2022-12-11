import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Helplarge extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Helplarge> {
  final fb = FirebaseFirestore.instance;
  var retrievedName = "";
  String query = "";
  String mailID = "";
  bool isValidForm = false;
  bool fi = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final ref = fb.collection("Help");
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    "Help",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      // backgroundColor: Color.fromRGBO(238, 244, 246, 1),
                    ),
                  ),
                ),
                // DoctorListSmall(),
              ],
            ),
            SizedBox(
              height: width / 70,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Mail ID',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: width / 140,
            ),
            Center(
              child: Container(
                width: width / 1.5,
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      mailID = val;
                      if (val.isEmpty) {
                        isValidForm = false;
                      } else {
                        isValidForm = true;
                      }
                    });
                  },
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Enter your Mail ID",
                    filled: true,
                    fillColor: Colors.blueAccent,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: width / 110,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Query',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: width / 140,
            ),
            Container(
              width: width / 1.5,
              child: TextField(
                // width: width / 2.5,
                maxLength: 200,
                maxLines: 7,
                onChanged: (val) {
                  setState(() {
                    query = val;
                    if (val.isEmpty) {
                      isValidForm = false;
                    } else {
                      isValidForm = true;
                    }
                  });
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Enter your Query",
                  filled: true,
                  fillColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            SizedBox(
              height: width / 75,
            ),
            FlatButton(
              onPressed: () {
                if (isValidForm) {
                  ref.add({
                    'email': mailID,
                    'query': query,
                  });
                  setState(() {
                    fi = false;
                  });
                } else {
                  setState(() {
                    fi = true;
                  });
                }
              },
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 40),
                height: 70,
                child: InkWell(
                  onTap: () {
                    if (isValidForm) {
                      ref.add({
                        'email': mailID,
                        'query': query,
                      });
                      setState(() {
                        fi = false;
                      });
                    } else {
                      setState(() {
                        fi = true;
                      });
                    }
                  },
                  child: Container(
                    width: width / 2.5,
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
                          child: Icon(Icons.assistant_photo_sharp),
                        ),
                        title: Center(
                          child: Text(
                            'Submit',
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
            SizedBox(
              height: width / 170,
            ),
            Text(fi ? "Enter the above field" : "submitted"),
          ],
        ),
      ),
    );
  }
}
