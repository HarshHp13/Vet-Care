import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/widgets/MessageBubble.dart';

class Messages extends StatelessWidget {
  final chatId;
  double width;
  Messages(this.width, this.chatId);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data.docs;
        print(messages);
        return ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 8,
          ),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (ctx, index) => MessageBubble(
            messages[index]['data'],
            messages[index]['from'],
            messages[index]['isImage'],
            messages[index]['timestamp'],
            key: ValueKey(messages[index].id),
            width: this.width,
          ),
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 10,
            );
          },
        );
      },
      stream: FirebaseFirestore.instance
          .collection("chats")
          .doc(this.chatId)
          .collection("messages")
          .orderBy(
            'timestamp',
            descending: true,
          )
          .snapshots(),
    );
  }
}
