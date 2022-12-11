import 'package:flutter/material.dart';
import 'package:vetcare/screen/AddPet.dart';
import 'package:vetcare/screen/ChatScreen.dart';

class PetListSmall extends StatelessWidget {
  String _imageURL = '';
  String _name = "";
  String _subtitle = '';
  Map<String, dynamic> _data;
  PetListSmall(Map<String, dynamic> data) {
    _name = data['Name'];
    _subtitle = data['Category'];
    _imageURL = data['imageURL'];
    _data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {},
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
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddPet(
                data: _data,
              ),
            ));
          },
          icon: Icon(Icons.edit)
        ),
      ),
    );
  }
}
