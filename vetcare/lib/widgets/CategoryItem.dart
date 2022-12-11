import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  String _imageName;
  double _width;
  String _title;
  CategoryItem(String imageName, String title, double width) {
    _imageName = imageName;
    _title = title;
    _width = width;
  }
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            color: Colors.black26,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = true;
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.asset(
                widget._imageName,
                fit: BoxFit.cover,
              ),
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  width: widget._width,
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 20),
                  decoration: BoxDecoration(
                    color: _selected
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    /*borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),*/
                  ),
                  child: Text(
                    widget._title,
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: _selected
                          ? Colors.white
                          : Theme.of(context).accentColor,
                    ),
                  ),
                ),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
