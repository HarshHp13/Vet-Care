import 'package:flutter/material.dart';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vetcare/screen/AllChats.dart';
import 'package:vetcare/screen/Payments.dart';
import 'package:vetcare/screen/SelectDoctor.dart';
import 'package:vetcare/widgets/UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

void Payment({String name, String image, int price, String description, String docId}){
  runApp(PaymentWeb(name: name,price: price,image: image, description: description, docId: docId));
}

class PaymentWeb extends StatelessWidget{
  static String route='/web';
  final String name;
  final String image;
  final int price;
  final String description;
  final String docId;
  PaymentWeb({this.name,this.price,this.image, this.description, this.docId});
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory("rzp-html",(int viewId) {
      IFrameElement element=IFrameElement();
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if(element.data=='MODAL_CLOSED'){
          Navigator.of(context).pushNamed(Payments.route);
        }
        else if(element.data=='SUCCESS'){
          print('PAYMENT SUCCESSFULL!!!!!!!');
          FirebaseFirestore.instance.collection('doctors').doc(docId).update({
            'payment':true,
            'timestamp': DateTime.now(),
          });
          // Navigator.of(context).pushNamed(AllChats.route);
        }
      });

      element.src='assets/payments.html?name=$name&price=$price&image=$image&description=$description';
      element.style.border = 'none';

      return element;
    });
    return  Container(
        child: Builder(builder: (BuildContext context) {
          return Container(
            child: HtmlElementView(viewType: 'rzp-html'),
          );
        }));
  }
}