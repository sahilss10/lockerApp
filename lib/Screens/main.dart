import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/Screens/wallet.dart';
import 'package:locker_app/Screens/profile.dart';
import 'package:locker_app/Screens/home.dart';
import 'drawer.dart';
import 'package:locker_app/Screens/transaction.dart';
import 'package:locker_app/settings.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

      ),

    );
  }
}