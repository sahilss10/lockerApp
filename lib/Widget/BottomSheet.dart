import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:locker_app/Transitions/SlideTransition.dart';
import 'package:locker_app/Pages/payment.dart';
import 'package:locker_app/helper/locker_data.dart';
import 'package:locker_app/helper/LOCKERS_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:locker_app/helper/helper_lists.dart';


class DraggableSheet extends StatelessWidget {
  dynamic lock;
  Struct locker;
  DraggableSheet(this.locker);

  Future getLockerData() async {
    List<Locker> list = new List();
    List<bool> boollist = new List();

    Firestore.instance
        .collection("Locker")
        .document(locker.title)
        .collection("EachLocker")
        .snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((doc) => list.add(new Locker(
          doc['available'] == "true" ? true : false,
          doc['rented to'],
          doc['locker no'],
          doc.documentID,
          doc['qrcode'])));
    });
    if (list != null) lockerList = list;
    boollist = List.generate(
        lockerList.length, (i) => lockerList[i].availability ? true : false);
    if (boollist != null) lockers = boollist;

    return lockerList;
  }

  @override
  Widget build(BuildContext context) {
    String time;
    DateFormat dateFormat = new DateFormat.Hm();
    DateTime now = DateTime.now();
    DateTime open = dateFormat.parse("5:00");
    open = new DateTime(now.year, now.month, now.day, open.hour, open.minute);
    DateTime close = dateFormat.parse("23:00");
    close =
    new DateTime(now.year, now.month, now.day, close.hour, close.minute);
    print(open.toString() + "  " + close.toString());
    Color t = Colors.red;
    if (now.isAfter(open) && now.isBefore(close)) {
      time = 'Open Now';
      t = Colors.green;
    } else
      time = "Closed";

    Color money = Colors.green;
    if (locker.availablelockers == "0") {
      money = Colors.red;
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      maxChildSize: 0.60,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height * 0.90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              locker.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22.4,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              locker.subtitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  fontSize: 12,
                                  letterSpacing: 0.2),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.lock_open_outlined,
                                      size: 16,
                                      color: money,
                                    ),
                                  ),
                                  color: Colors.grey[900],
                                  elevation: 4,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  locker.availablelockers.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.4),
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.attach_money,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.grey[900],
                                  elevation: 4,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  locker.price.toString() + ' rs/h',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.4),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0, top: 15),
                        child: ClipRRect(
                          child: Image.network(
                            locker.image,
                            height: 110.0,
                            width: 120.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 24),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        onPressed: () {
                          selectedLock = locker;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPaymentPage(locker)),
                          );
                        },
                        color: Colors.indigo[500],
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'BOOK LOCKER',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              wordSpacing: 4,
                              letterSpacing: 0.3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Timings',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                          fontSize: 12,
                          letterSpacing: 0.2),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      '5:00 AM - 11:00 PM',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900],
                          fontSize: 18,
                          letterSpacing: 0.2),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      time,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: t,
                          fontSize: 12.4,
                          letterSpacing: 0.2),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Contacts',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                          fontSize: 12,
                          letterSpacing: 0.2),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          size: 16,
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          locker.mob,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[900],
                              fontSize: 18,
                              letterSpacing: 0.2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.web_asset,
                          size: 16,
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          locker.email,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[900],
                              fontSize: 14.4,
                              letterSpacing: 0.2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Full Address',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                          fontSize: 12,
                          letterSpacing: 0.2),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      locker.title + " - " + locker.subtitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900],
                          fontSize: 16.5,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Container(
                    height: 0,
                    width: 0,
                    child: FutureBuilder(
                      future: getLockerData(),
                      builder: (context, snapshot) {
                        print(lockerList.length.toString() +
                            " lockers from bottomshit");
                        print(lockerList.length.toString() +
                            " lockerList from bottomshit");
                        if (snapshot.data != null)
                          return Container(
                            width: 0,
                            height: 0,
                          );
                        else
                          return  CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}