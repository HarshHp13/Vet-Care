import 'package:flutter/cupertino.dart';

class Pets {
  final String name;
  final String category;
  Pets({@required this.name, @required this.category});

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'category':category,
    };
  }


}