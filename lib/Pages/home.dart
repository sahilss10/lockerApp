import 'package:flutter/material.dart';
import 'package:locker_app/Paint/CustomPaintHome.dart';
import 'package:locker_app/Transitions/FadeTransition.dart';
import 'package:locker_app/Pages/map.dart';
import 'package:locker_app/Widget/recents.dart';
import 'package:locker_app/services/auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.auth, @required this.onSignOut});
  final VoidCallback onSignOut;
  final AuthBase auth;
  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  //Function _signOut;

  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Icon(
                      Icons.menu,
                      color: Colors.white.withOpacity(0.9),
                      size: 26,
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
                        enabled: false,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Search for a locker nearby',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                                letterSpacing: 0.2)),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(context, FadeRoute(page: MapView()));
                        },
                        child: Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.orange[400],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Recents(),
            ],
          )
        ],
      ),
    );
  }
}
