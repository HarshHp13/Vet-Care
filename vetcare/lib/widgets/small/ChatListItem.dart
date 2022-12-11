import 'package:flutter/material.dart';
import 'package:vetcare/screen/ChatScreen.dart';

class ChatListItemSmall extends StatelessWidget {
  String _imageURL = '';
  String _name = "";
  String _subtitle = '';
  String _docId;
  ChatListItemSmall(Map<String, dynamic> data, String docId) {
    _name = data['name'];
    _subtitle = data['specialty'];
    _imageURL = data['image'];
    _docId=docId;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatScreen(
          Name: _name,
          DocUid: _docId,
          Desc: _subtitle,
        ))
        );},
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        leading:CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(_imageURL ??
              "https://i.etsystatic.com/21753258/r/il/f0c888/3228834318/il_340x270.3228834318_tve6.jpg"),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          _name,
          style: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text(
          _subtitle,
          style: TextStyle(
            fontFamily: "Quicksand",
          ),
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
