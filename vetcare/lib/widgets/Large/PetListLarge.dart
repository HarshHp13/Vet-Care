import 'package:flutter/material.dart';
import 'package:vetcare/screen/AddPet.dart';
import 'package:vetcare/screen/ChatScreen.dart';

class PetListLarge extends StatelessWidget {
  String _imageURL = '';
  String _name = "";
  String _category = '';
  String _weight;
  String _dob;
  Map<String, dynamic> _data;
  PetListLarge(Map<String, dynamic> data) {
    _name = data['Name'];
    _category = data['Category'];
    _imageURL = data['imageURL'];
    _weight=data['Weight'];
    _dob=data['DOB'];
    _data=data;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200,
        padding: EdgeInsets.all(10),
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
            SizedBox(height: 5),
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
            Text(
              _category,
              style: TextStyle(
                fontFamily: "Quicksand",
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DOB",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1.color,
                    fontFamily: 'Quicksand',
                  ),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  child: Text(
                    _dob ?? 'error1',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1.color,
                      fontFamily: 'Quicksand',
                    ),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Weight",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1.color,
                    fontFamily: 'Quicksand',
                  ),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _weight ?? 'error1',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1.color,
                    fontFamily: 'Quicksand',
                  ),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            SizedBox(height: 5),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              onPressed: (){Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddPet(
                  data: _data,
                ),
              ));
                },
              child: Container(
                width: 100,
                child: Center(child: Text("Edit Pet")),
              )
            )
          ],
        ),
      ),
    );
  }
}
