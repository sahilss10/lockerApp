import 'package:flutter/material.dart';
import 'package:locker_app/Pages/home.dart';
import 'package:locker_app/Pages/landing_page.dart';
import 'package:locker_app/services/auth.dart';
//import 'package:locker_app/Pages/first_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
