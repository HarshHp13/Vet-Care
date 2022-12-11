// import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'package:vetcare/screen/OTPScreen.dart';
import 'dart:math';
import 'package:date_field/date_field.dart';
import 'package:vetcare/screen/UserProfile.dart';
import 'package:vetcare/services/LoginAndSignUpService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vetcare/services/database.dart';
import '../OTPForm.dart';
import 'package:image_picker/image_picker.dart';

class AddPetLarge extends StatefulWidget {
  const AddPetLarge({this.data});
  final Map<String, dynamic> data;
  @override
  _AddPetLargeState createState() =>
      _AddPetLargeState();
}

class _AddPetLargeState extends State<AddPetLarge> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationService _authenticationService = AuthenticationService.instance;
  bool _connecting = false;
  FirebaseFirestore add= FirebaseFirestore.instance;
  String _name;
  String _weight;
  String _dob;
  String _category;
  String _id=DateTime.now().toString();
  final nameHolder=TextEditingController();
  final nameHolder1=TextEditingController();
  Uint8List image;
  // var imagePath;
  String _imageURL;

  @override
  void initState() {
    super.initState();
    if(widget.data != null){
      _name=widget.data['Name'];
      _weight=widget.data['Weight'];
      _dob=widget.data['DOB'];
      _category=widget.data['Category'];
      _id=widget.data['id'];
      _imageURL = widget.data['imageURL'];
    }
  }
  void _saveForm() {
    final form=_formKey.currentState;
    setState(() {
      _connecting = true;
    });
    if(form.validate()){
      form.save();
      _save(context);
      form.reset();
    }
    setState(() {
      _connecting = false;
    });
  }

  void _save(BuildContext context){
    final database=Database();
    database.save({
      'Name':_name,
      'Weight':_weight,
      'DOB':_dob,
      'Category':_category,
      'id':_id,
      'imageURL':_imageURL,
    });
    Navigator.of(context).pushNamed(UserProfile.route);
  }

  void pickImage() async{
    try {
      FilePickerResult photo =await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      if (photo == null) return;
      // final imagePermanent = await saveImagePermanently(photo.path);
      // final imagePermanent=File(photo.path);
      // imagePath=photo.files.first.path;

      Uint8List file = await photo.files.first.bytes;
      if(_imageURL!=null) FirebaseStorage.instance.refFromURL(_imageURL).delete();
      setState(() {
        this.image= file;

      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }



  Future uploadToStorage(Uint8List image) async {
    if (image==null) return;
    final dateTime = DateTime.now();
    final uid = FirebaseAuth.instance.currentUser.uid;
    final path = '$uid/$dateTime+$_name.png';
    TaskSnapshot snapshot=await FirebaseStorage.instance
        .ref(path)
        .putData(image);
    _imageURL=(await snapshot.ref.getDownloadURL()).toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double right = min(width * 0.1, 200);
    print(right);
    return width>1000
        ? Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/form_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: max((height - 500) / 2, 120),
            right: right,
            left: width - right - 400,
            // bottom: max((height - 500) / 2, 120),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 60,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              /**
               * Intial of the content logo and text
               */
              Center(
                child: InkWell(
                  onTap: (){pickImage();},
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.grey[200], width: 2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child:
                        image != null
                            ? ClipOval(
                          child: Image.memory(
                            image,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        )
                            :_imageURL !=null
                            ? ClipOval(
                          child: Image.network(
                            _imageURL,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        )
                            :ClipOval(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Icon(
                              Icons.pets,
                              color: Colors.grey[400],
                              size: 120,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.white, width: 2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              // border: Border.all(color: Colors.white, width: 2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {pickImage();},
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              /**
               * The form to enter Phone number
               */

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _name,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(209, 222, 224, 1),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "Name",
                      ),
                      keyboardType: TextInputType.name,
                      onSaved:(value)=> _name=value,
                      validator: (value)=> value.isNotEmpty ? null : "Required Field",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        initialValue: _weight,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(209, 222, 224, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Weight",
                        ),
                        keyboardType: TextInputType.number,
                        onSaved:(value)=> _weight=value,
                        validator: (value)=> value.isNotEmpty ? null : "Required Field"
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DateTimeFormField(
                      initialValue:widget.data==null ? null:DateTime.parse(_dob),
                      onSaved:(value)=> _dob=value.toString(),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(209, 222, 224, 1),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "DOB",

                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                        value: _category,
                        items: ["Dog","Cat","Dairy","Other"]
                            .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        onChanged: (_) {},
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(209, 222, 224, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Category",
                        ),
                        onSaved:(value)=> _category=value,
                        validator: (value)=> value.isNotEmpty ? null : "Required Field"
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // Add Pet Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(
                          width * 5 / 6 - 0.05 * width,
                          height * 0.01,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                          horizontal: width * 0.02,
                        ),
                      ),
                      onPressed: _connecting ? null : () async{
                        await uploadToStorage(image).then((value) => _saveForm());
                      },
                      child: Text(
                        widget.data == null ? "Add Pet": "Save",
                        style: TextStyle(
                          fontSize: min(width * 0.05, 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    )
        :Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "VET CARE",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // the white container to contain the form
        child: Container(
          margin: EdgeInsets.only(
            left: max((width - 400) / 2, 40),
            top: max((height - 0.70 * height - 100) / 2, 80),
            right: max((width - 400) / 2, 40),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 0.05 * height,
            horizontal: 0.06 * width,
          ),
          alignment: Alignment.center,
          width: width * 370.0 / 428.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          // content of the form
          child: Column(
            children: [
              /**
               * Intial of the content logo and text
               */
              Center(
                child: InkWell(
                  onTap: (){pickImage();},
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.grey[200], width: 2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child:
                        image != null
                            ? ClipOval(
                          child: Image.memory(
                            image,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        )
                            :_imageURL !=null
                            ? ClipOval(
                          child: Image.network(
                            _imageURL,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        )
                            :ClipOval(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Icon(
                              Icons.pets,
                              color: Colors.grey[400],
                              size: 120,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.white, width: 2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              // border: Border.all(color: Colors.white, width: 2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {pickImage();},
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                height: height * 0.025,
              ),
              /**
               * The form to enter Pet Details
               */

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _name,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(209, 222, 224, 1),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "Name",
                      ),
                      keyboardType: TextInputType.name,
                      onSaved: (value) => _name = value,
                      validator: (value) =>
                      value.isNotEmpty ? null : "Required Field",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        initialValue: _weight,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(209, 222, 224, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Weight",
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _weight = value,
                        validator: (value) =>
                        value.isNotEmpty ? null : "Required Field"),
                    const SizedBox(
                      height: 10,
                    ),
                    DateTimeFormField(
                      initialValue:
                      widget.data == null ? null : DateTime.parse(_dob),
                      onSaved: (value) => _dob = value.toString(),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(209, 222, 224, 1),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: "DOB",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                        value: _category,
                        items: ["Dog", "Cat", "Dairy", "Other"]
                            .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        onChanged: (_) {},
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(209, 222, 224, 1),
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Category",
                        ),
                        onSaved: (value) => _category = value,
                        validator: (value) =>
                        value.isNotEmpty ? null : "Required Field"),
                    const SizedBox(
                      height: 12,
                    ),
                    // Add Pet Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(
                          width * 5 / 6 - 0.05 * width,
                          height * 0.01,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                          horizontal: width * 0.02,
                        ),
                      ),
                      onPressed: _connecting ? null : () async{
                        await uploadToStorage(image).then((value) => _saveForm());
                      },
                      child: Text(
                        widget.data == null ? "Add Pet" : "Save",
                        style: TextStyle(
                          fontSize: min(width * 0.05, 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
