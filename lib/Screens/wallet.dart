import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locker_app/Models/WalletModel.dart';
import 'package:locker_app/Screens/database.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Crypto Wallet',
      home: Wallet(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Wallet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // cryptoPortfolioItem() => Card(

    cryptoPortfolioItem(IconData icon, String name, String amount) =>
        Card(
          elevation: 1.0,
          child: InkWell(
            onTap: () => print("tapped"),
            child: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 15.0),

                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(amount,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),

                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        );
    return StreamBuilder<WalletModel>(
      stream: Database(uid: "uAvnYzZnM2WQHy1oKhEL").walletData,
      builder: (context, snapshot) {

    if(!snapshot.hasData)
    {
    return MaterialApp(
    home: Scaffold(
    appBar: AppBar(title: Text("Transaction"),),
    body: Center(child: Text("No data")),
    ),
    );
    }
    else {
      WalletModel walletModel = snapshot.data;

      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF81269D),
                          const Color(0xFFEE112D)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        // stops: [0.0, 0.1],
                      ),
                    ),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .40,
                    padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text("Balance",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w500)),

                          ],
                        ),
                        SizedBox(height: 40),
                        Text(
                          walletModel.balance.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),


                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    right: 10.0,
                    left: 10.0),
                child: new Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ListView(
                    children: <Widget>[
                      cryptoPortfolioItem(
                          FontAwesomeIcons.btc, "VIT", "+400.0"),
                      cryptoPortfolioItem(FontAwesomeIcons.ethereum, "MIT",
                          "-1089.86"),
                      cryptoPortfolioItem(
                        FontAwesomeIcons.xRay, "PICT", "+22998.13",
                      ),

                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      );
    }
      }
    );
  }
}