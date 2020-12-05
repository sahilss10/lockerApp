import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/Models/UserModel.dart';
import 'package:locker_app/Screens/drawer.dart';
import 'package:typicons_flutter/typicons.dart';
import 'package:locker_app/Models/TransactionModel.dart';
import 'package:locker_app/Screens/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {


  @override
  _TransactionState createState() => _TransactionState();
}

var doc;

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('User').document('ygJ6ddzC1sabfnFmfgmufHXhGo12').
          collection('Transaction').snapshots(),

      builder: (context, snapshot) {

        if (!snapshot.hasData) {

          return Scaffold(body: CircularProgressIndicator());
        }

        else {

          doc = snapshot.data.documents;
          print(doc.length);

          return Scaffold(
            appBar: AppBar(title: Text("Transactions"),),
            drawer: DrawerWidget(),
            body: Padding(padding:
            const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Expanded(
                    child: ListView.builder(
                        itemCount: doc.length, itemBuilder: (context, index) {

                      return Center(child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 4.0),
              child: Container(
                height: 220,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(doc[index].data()['lockerName'], style: TextStyle(
                                    fontSize: 22, color: Colors.white70),)
                            ),





                          ],

                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),

                              child: Text(DateFormat('yyyy-MM-dd - kk:mm').format(doc[index].data()['startTime'].toDate()),
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                'Duration: ' + " " + doc[index].data()['duration'].toString(),
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                doc[index].data()['paymentMethod'].toString(),
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),

                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                "Rs." + doc[index].data()['billAmount'].toString(),
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),


                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(doc[index].data()['lockerAdd'].toString(),style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white70),)
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
    ),
            ),);
                    }),


                  )
                ],

              ),
            ),
          );
        }
      }
    );
  }
}

 class _cardItem extends StatefulWidget{
  @override
  __cardItemState createState() => __cardItemState();
}

class __cardItemState extends State<_cardItem> {
  @override
  Widget build(BuildContext context) {

      }
}


