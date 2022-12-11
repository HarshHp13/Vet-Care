import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vetcare/screen/HomePage.dart';
import 'dart:math';
import 'package:date_field/date_field.dart';
import 'package:vetcare/screen/UserProfile.dart';
import 'package:vetcare/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPetSmall extends StatefulWidget {
  const AddPetSmall({this.data});
  final Map<String, dynamic> data;
  @override
  _AddPetSmallState createState() => _AddPetSmallState();
}

class _AddPetSmallState extends State<AddPetSmall> {
  final _formKey = GlobalKey<FormState>();
  File image;
  var _url;
  // AuthenticationService _authenticationService = AuthenticationService.instance;
  bool _connecting = false;
  FirebaseFirestore add = FirebaseFirestore.instance;
  String _name;
  String _weight;
  String _dob;
  String _category;
  String _id = DateTime.now().toString();
  String _imageURL;
  final nameHolder = TextEditingController();
  final nameHolder1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _name = widget.data['Name'];
      _weight = widget.data['Weight'];
      _dob = widget.data['DOB'];
      _category = widget.data['Category'];
      _id = widget.data['id'];
      _imageURL = widget.data['imageURL'];
    }
  }

  void _saveForm() {
    final form = _formKey.currentState;
    setState(() {
      _connecting = true;
    });
    if (form.validate()) {
      form.save();
      _save(context);
      form.reset();
    }
    setState(() {
      _connecting = false;
    });
  }

  void _save(BuildContext context) {
    final database = Database();
    database.save({
      'Name': _name,
      'Weight': _weight,
      'DOB': _dob,
      'Category': _category,
      'id': _id,
      'imageURL': _imageURL,
    });
    Navigator.of(context).pushNamed(UserProfile.route);
  }

  Future<ImageSource> showImageSource(BuildContext context) async {
    if(Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context)=> CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: ()=> Navigator.of(context).pop(ImageSource.camera),
                child: Text('Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: ()=> Navigator.of(context).pop(ImageSource.gallery),
                child: Text('Gallery'),
              ),
            ],
          )
      );
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context)=>Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: (){pickImage(ImageSource.camera);}
              ),
              ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                  onTap: (){pickImage(ImageSource.gallery);}
              ),
            ],
          )
      );
    }
  }

  void pickImage(ImageSource source) async{
    try {
      final photo = await ImagePicker().pickImage(source: source);
      if (photo == null) return;
      // final imagePermanent = await saveImagePermanently(photo.path);
      final imagePermanent=File(photo.path);
      if(_imageURL!=null) FirebaseStorage.instance.refFromURL(_imageURL).delete();
      setState(() {
        this.image= imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }



  Future uploadToStorage(File image) async {
    if (image==null) return;

    final dateTime = DateTime.now();
    final uid = FirebaseAuth.instance.currentUser.uid;
    final path = '$uid/$dateTime+$_name.png';
    TaskSnapshot snapshot=await FirebaseStorage.instance
        .ref(path)
        .putFile(image);
    _imageURL=(await snapshot.ref.getDownloadURL()).toString();
  }

  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print((height - 0.46 * height - 100));
    /**
     * single child scroll view so that if very small screen then it can be
     * scrolled if needed
     */
    return Scaffold(
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
                  onTap: (){showImageSource(context);},
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
                          child: Image.file(
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
                              onPressed: () {showImageSource(context);},
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
