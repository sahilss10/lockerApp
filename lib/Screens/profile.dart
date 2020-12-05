import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locker_app/Screens/drawer.dart';
import 'package:provider/provider.dart';
import 'package:locker_app/Models/UserModel.dart';
import 'database.dart';


class Profile extends StatefulWidget{


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name, email, phone;
  UserModel user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

  }


  void fetchData () async
  {
    setState(() {

    });

  }



  @override
  Widget build(BuildContext context) {

   // final user = Provider.of<UserID> (context);
    return StreamBuilder<UserModel>(
      stream: Database(uid:

      'p0YVyEHBEAM7quLuXctIr6iN0MN2').userData,
      builder: (context, snapshot) {

        if(!snapshot.hasData)
          {
            return MaterialApp(
                home: Scaffold(
                appBar: AppBar(title: Text("Profile"),),
                 body: Center(child: Text("No data")),
         ),
            );
          }
        else {
          UserModel userModel = snapshot.data;

          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(title: Text("Profile"),),
              drawer: DrawerWidget(),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: new CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(userModel.photoUrl),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 70.0)),
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Text(
                          userModel.name,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Divider(color: Colors.black45,),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Text(
                          userModel.email,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Divider(color: Colors.black45,),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          "Phone",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Text(
                          userModel.phoneNo.toString() == "null" ? "NA" : userModel.phoneNo.toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Divider(color: Colors.black45,),
                       /* Padding(padding: EdgeInsets.only(top: 8.0)),
                        Divider(color: Colors.black45,),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          "Aadhar card no",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Text(
                          userModel.aadharCard,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        Divider(color: Colors.black45,),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          "Pancard no",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Text(
                          userModel.panCard,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500
                          ),
                        ),*/

                      ],
                    ),
                  ),
                ),

              ),
            ),
          );
        }
      }
    );
  }

}
