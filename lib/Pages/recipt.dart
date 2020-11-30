import 'package:flutter/material.dart';
import 'package:locker_app/Pages/map.dart';
import 'package:locker_app/Pages/map_tracking.dart';
import 'package:locker_app/services/payment_service.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class MyRecipt extends StatefulWidget {
  PaymentTransaction transaction;

  MyRecipt(this.transaction);

  @override
  State createState() => _MyReciptState();
}

class _MyReciptState extends State<MyRecipt> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String qrData ;
  @override
  void initState() {
    setState(() {
      qrData= widget.transaction.qrcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _drawerKey,
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
                      builder: (BuildContext context) => MapView()));
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child:
                      GestureDetector(

                        onTap: (){_drawerKey.currentState.openDrawer();},
                        child:
                        Icon(
                          Icons.menu,
                          color: Colors.white.withOpacity(0.9),
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

                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: Text(
                        'Locker Code',
                        style: TextStyle(
                            fontSize: 24.4,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: QrImage(
                    //plce where the QR Image will be shown
                    data: qrData,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Locker Pass Code',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[400],
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                               widget.transaction.qrcode,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Locker Number',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[400],
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.transaction.lockerName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 32),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'From',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[400],
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.transaction.startTime.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'To',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[400],
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.transaction.endTime.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Full Address',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                        fontSize: 13,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                      widget.transaction.address,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                        fontSize: 12.4,
                        letterSpacing: 0.2),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      onPressed: () {

                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => MapTrack(widget.transaction,qrData),
                          ),
                        );

                      },
                      color: Colors.indigo[500],
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'DIRECTION',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            wordSpacing: 2,
                            letterSpacing: 0.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
