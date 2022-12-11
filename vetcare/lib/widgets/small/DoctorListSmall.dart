import 'package:flutter/material.dart';
import 'package:vetcare/screen/ChatScreen.dart';
import 'package:vetcare/screen/Payments.dart';

class DoctorListSmall extends StatelessWidget {
  String _imageURL = '';
  String _name = "";
  String _subtitle = '';
  String _charge='';
  bool _payment=false;
  Map<String, dynamic> _Data;
  String _DocUid;
  DoctorListSmall(Map<String, dynamic> data, String DocUid) {
    _name = data['name'];
    _subtitle = data['specialty'];
    _imageURL = data['image'];
    _charge= data['charge'];
    _payment= data['payment'];
    _Data=data;
    _DocUid=DocUid;
  }

  @override
  Widget build(BuildContext context) {
    _Data['docId']=_DocUid;
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {
          if(_payment){
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ChatScreen(
              DocUid: _DocUid,
              Name: _name,
              Desc: _subtitle
            ))
            );
          }
          else{
            Navigator.of(context).pushNamed(Payments.route,arguments: _Data);
          }
          },
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
        trailing: Text(
          "Rs. $_charge",
          style: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
