import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/widgets/Large/ChatListItemLarge.dart';
import 'package:vetcare/widgets/small/ChatListItem.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(FirebaseFirestore.instance.collection("/chats").get());
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10),
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
              return Center(
                child: Text("No Chats found"),
              );
            }
            final chatDocs = snapshot.data.docs;
            return width < 1000
                ? ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                    snapshot.data.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      // subtitle: data['date'],
                      // trailing: Text("Rs.${data['amount']}"),
                    );
                  }
                  return CircularProgressIndicator();
                },
                future: FirebaseFirestore.instance
                    .collection("user")
                    .doc(chatDocs[index].reference.id)
                    .get(),
              ),
            )
                : ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                    snapshot.data.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      // subtitle: data['date'],
                      // trailing: Text("Rs.${data['amount']}"),
                    );
                  }
                  return CircularProgressIndicator();
                },
                future: FirebaseFirestore.instance
                    .collection("user")
                    .doc(chatDocs[index].reference.id)
                    .get(),
              ),
            );
          },
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection("chats")
              .snapshots(),
        ),
      ),
    );
  }
}
