import 'package:flutter/material.dart';
import 'package:locker_app/Screens/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[

          IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },)
        ],
        title: Text("My App"),
        backgroundColor: Colors.deepPurple,
      ),


      drawer: DrawerWidget(),
      body: Text("Home"),


    );
  }
}

