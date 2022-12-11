import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userId;
  final bool isImage;
  final timeStamp;
  final Key key;
  double width;
  String currentUser = FirebaseAuth.instance.currentUser.uid;

  MessageBubble(this.message, this.userId, this.isImage, this.timeStamp,
      {this.key, this.width = 100});

  @override
  Widget build(BuildContext context) {
    bool isMe = this.userId == currentUser;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: isImage ? width * 0.5 : width * 0.8,
        ),
        padding: EdgeInsets.symmetric(
          vertical: isImage ? 10 : 5,
          horizontal: 10,
        ),
        child: isImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(this.message, fit: BoxFit.contain))
            : SelectableText(
                this.message,
                style: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: isMe ? Colors.white : Theme.of(context).accentColor,
                ),
              ),
      ),
    );
  }
}
