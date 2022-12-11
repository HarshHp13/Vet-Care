import 'package:flutter/material.dart';
import 'package:vetcare/screen/ChatScreen.dart';
import 'package:vetcare/screen/Payments.dart';

class DoctorListLarge extends StatelessWidget {
  String _imageURL = '';
  String _name = "";
  String _subtitle = '';
  String _charge='';
  bool _payment=false;
  Map<String, dynamic> _Data;
  String _DocUid;
  DoctorListLarge(Map<String, dynamic> data, String DocUid) {
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
    return InkWell(
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
      child: Container(
        height: 250,
        width: 180,
        padding: EdgeInsets.all(15),
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
            // SizedBox(height: 10),
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
            Text(
              "Rs. $_charge",
              style: TextStyle(
                fontFamily: "Quicksand",
                color: Theme.of(context).primaryColor,
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
