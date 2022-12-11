import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/widgets/Messages.dart';
import 'package:vetcare/widgets/NewMessage.dart';

class ChatScreen extends StatefulWidget {
  static String route = "/ChatScreen";
  final DocUid;
  final Name;
  final Desc;
  ChatScreen({Key key,this.DocUid, this.Name, this.Desc}): super(key : key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatId ;
  bool sessionValid = true;
  double width;
  final ChatRef= FirebaseFirestore.instance.collection('chats');
  final uid=FirebaseAuth.instance.currentUser.uid;

  @override
  void initState(){
    super.initState();
    ChatRef.where('users', isEqualTo: {uid:true, this.widget.DocUid:true }).limit(1).get().then(
      (QuerySnapshot snapshot){
        if(snapshot.docs.isNotEmpty){
          chatId=snapshot.docs.single.id;
        }else{
          ChatRef.add(
            {
              'users':{uid: true, this.widget.DocUid: true,}
            }).then((value) => {
              chatId=value.id
            });
        }
      }
    ).catchError((error){});
  }

  @override
  Widget build(BuildContext context) {
    final name = this.widget.Name;
    final Desc= this.widget.Desc;
    width = MediaQuery.of(context).size.width;
    if (width < 1000) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            name!=null?name:"error",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: Container(
          color: Color.fromRGBO(238, 244, 246, 1),
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Messages(width, chatId),
                ),
              ),
              if (sessionValid) NewMessage(width, chatId),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width / 10,
                          height: width / 10,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(4000),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          name!=null?name:"error",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          Desc!=null?Desc:"error2",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Color.fromRGBO(238, 244, 246, 1),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                            top: 20,
                          ),
                          child: Messages(width * 0.7, chatId),
                        ),
                      ),
                      if (sessionValid) NewMessage(width * 0.7, chatId),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
