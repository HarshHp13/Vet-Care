import 'package:flutter/material.dart';
import 'package:vetcare/widgets/HamburgerMenu.dart';
import 'package:vetcare/widgets/small/SelectPetSmall.dart';
import 'package:vetcare/widgets/Large/SelectPetLarge.dart';

class SelectPet extends StatelessWidget {
  static String route = "/allPets";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
        // floatingActionButton: Container(
        //   // margin: EdgeInsets.symmetric(horizontal: 40),
        //   margin: EdgeInsets.only(left: width < 1000 ? 30 : 1100),
        //   height: 70,
        //   width: width,
        //   child: FloatingActionButton(
        //     onPressed: () {},
        //     child: InkWell(
        //       onTap: () {},
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black12,
        //               blurRadius: 2,
        //               offset: Offset(1, 1),
        //             )
        //           ],
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: ListTile(
        //             leading: Container(
        //               padding: EdgeInsets.all(10),
        //               decoration: BoxDecoration(
        //                 color: Color.fromRGBO(225, 229, 234, 1),
        //                 borderRadius: BorderRadius.circular(1000),
        //               ),
        //               child: Icon(Icons.pets),
        //             ),
        //             title: Center(
        //               child: Text(
        //                 'Add Pet',
        //                 style: TextStyle(
        //                   color: Theme.of(context).accentColor,
        //                   fontFamily: 'Quicksand',
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
                "Vet Care",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: HamburgerMenu(),
        ),
        body: width < 1000
            ? islandscape
                ? SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.25,
                        ),
                        child: SelectPetSmall()),
                  )
                : SelectPetSmall()
            : SelectPetLarge());
  }
}
