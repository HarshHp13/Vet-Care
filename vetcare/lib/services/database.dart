import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:vetcare/screen/models/Pets.dart';
import 'package:vetcare/widgets/small/PetListSmall.dart';

// abstract class Database {
//   Future<void> save(Map<String, dynamic> data,String name);
// }

class Database{
  final path="pets/${FirebaseAuth.instance.currentUser.uid}/pet";
  Future<void> save(Map<String, dynamic> data) async {
    final docref=FirebaseFirestore.instance
        .collection(path)
        .doc(data['id']);
    await docref.set(data);
  }

}

