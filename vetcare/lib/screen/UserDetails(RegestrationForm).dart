import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:vetcare/widgets/Large/userdetailsLarge.dart';
import 'package:vetcare/widgets/small/userdetailsSmall.dart';



class userdetails extends StatelessWidget {
  static String route = '/auth';
  const userdetails({this.data});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    final phoneNumber= data['phonenumber'];
    //print(test);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(207, 198, 189, 1),
        ),
        child: (width < height || width < 1000 || height < 600)
            ? userdetailsSmall(phoneNumber,data)
            :  userdetailsLarge(phoneNumber,data),
      ),
    );
  }
}