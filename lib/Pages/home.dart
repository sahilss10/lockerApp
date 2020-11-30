import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:locker_app/Pages/landing_page.dart';
import 'package:locker_app/helper/helper_lists.dart';
import 'package:locker_app/Pages/map.dart';
import 'package:locker_app/Paint/CustomPaintHome.dart';
import 'package:locker_app/Transitions/FadeTransition.dart';

import 'package:locker_app/Widget/recents.dart';
import 'package:locker_app/services/auth.dart';
import 'package:locker_app/helper/LOCKERS_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.auth});

  final AuthBase auth;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchAddr;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();


  _MyHomePageState();




  Future  getMarkerData () async {
    setState(() {

      Firestore.instance.collection("Locker").snapshots().listen((snapshot) {
        snapshot.documents.forEach((doc) =>   recentList.add(
            new Struct(
                doc['name'], doc['address'],  doc['review']+0.0, doc['charge'].toString(),
                doc['location'].latitude,doc['location'].longitude,doc['available locker'].toString(),
                doc['image'].toString(),doc['mob'].toString(),doc['email'],doc['total locker'].toString())
        ));
      });

    });
    return recentList;
  }


  @override
  //Function _signOut;

  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,

      body: Stack(
        children: <Widget>[
          TopBar_home(),
          Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child:
                      GestureDetector(

                        onTap: (){
                          _drawerKey.currentState.openDrawer();},
                        child:
                        Icon(
                          Icons.menu,
                          color: Colors.blue.withOpacity(0.9),
                          size: 26,
                        ),
                      ),
                    ),
                    title: Center(
                      child: Text(
                        'Lockers',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quickstand'),
                      ),
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: FlatButton(
                          onPressed: ()async {
                            await widget.auth.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (c) => LandingPage(auth: widget.auth)),
                                    (r) => false);
                          },

                          child: Icon(
                            Icons.settings,
                            color: Colors.white.withOpacity(0.9),
                            size: 24,
                          ),
                          //onPressed: _signOut,
                        ),
                      )
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28, top: 40, right: 28, bottom: 10),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide.none,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        title: TextField(
                          enabled: true,

                          decoration: InputDecoration.collapsed(
                              hintText: 'Search for a locker nearby',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                  letterSpacing: 0.2)),
                        ),
                        trailing: Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.orange[400],
                        ),
                        onTap: (){
                          Navigator.push(context,FadeRoute(page: MapView()));
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                    flex: 6,
                    child:
                    FutureBuilder(
                        future: getMarkerData(),
                        builder:(context,snapshot){
                          if(snapshot.data!=null)
                            return Recents();
                          else
                            return CircularProgressIndicator();
                        })
                )
              ]
          )

        ],
      )
      ,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text("ramesh@gmail.com"),
              accountName: new Text("Ramesh"),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
//                        backgroundImage: new NetworkImage(currentProfilePic),
                ),
                onTap: () => print("This is your current account."),
              ),

              decoration: new BoxDecoration(
                color: Colors.indigo[500],
                /*image: new DecorationImage(
                            image: new NetworkImage(
                                "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                            fit: BoxFit.fill)*/
              ),
            ),
            new ListTile(
                title: new Text("Profile"),
                trailing: new Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => MapView()));
                }),
            new ListTile(
                title: new Text("Wallet"),
                trailing: new Icon(Icons.account_balance_wallet),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => MapView()));
                }),
            new ListTile(
                title: new Text("Transactions"),
                trailing: new Icon(Icons.monetization_on),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>MapView()));
                }),
            new Divider(),
            new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),



      floatingActionButton: FloatingActionButton.extended(


        label: Text('Track'),

        backgroundColor: Colors.red,
        icon: Icon(Icons.where_to_vote),
      ),
    );


  }


}