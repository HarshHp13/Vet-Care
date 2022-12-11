import 'package:flutter/material.dart';
import 'package:vetcare/screen/ChatScreen.dart';

class ChatListItemLarge extends StatelessWidget {
  String _imageURL = '';
  String _name = "";
  String _subtitle = '';
  String _docId;
  ChatListItemLarge(Map<String, dynamic> data, String docId) {
    _name = data['name'];
    _subtitle = data['specialty'];
    _imageURL = data['image'];
    _docId=docId;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatScreen(
        Name: _name,
        DocUid: _docId,
        Desc: _subtitle,
      ))
      );},
      child: Container(
        width: 180,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(150),
              ),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(_imageURL ??
                    "https://i.etsystatic.com/21753258/r/il/f0c888/3228834318/il_340x270.3228834318_tve6.jpg"),
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _name,
              style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 18,
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              _subtitle,
              style: TextStyle(
                fontFamily: "Quicksand",
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}
