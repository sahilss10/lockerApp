import 'package:flutter/material.dart';
import 'package:locker_app/Models/UserModel.dart';
import 'package:locker_app/Screens/database.dart';
import 'package:locker_app/Screens/profile.dart';
import 'package:locker_app/Screens/transaction.dart';
import 'package:locker_app/Screens/wallet.dart';



class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream:  Database(uid: 'p0YVyEHBEAM7quLuXctIr6iN0MN2').userData,
      builder: (context, snapshot) {
        UserModel userModel = snapshot.data;

        if (snapshot.hasData) {
          return Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(accountName: Text(userModel.name),
                  accountEmail: Text(userModel.email),
                  //currentAccountPicture: Image.network("https://talentrecap.com/wp-content/uploads/2020/04/One-Direction-1200x900.jpg")
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userModel.photoUrl),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("My profile"),
                  onTap: (){

                    Navigator.of(context).pop();
                    Navigator.push(context, new MaterialPageRoute(builder: (context) =>

                      new Profile()
                    ));

                  },



                ),

                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Transactions"),

                  onTap: (){

                    Navigator.of(context).pop();
                    Navigator.push(context, new MaterialPageRoute(builder: (context) =>

                    new Transaction()
                    ));

                  },

                ),


                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text("Wallet"),

                  onTap: (){

                    Navigator.of(context).pop();
                    Navigator.push(context, new MaterialPageRoute(builder: (context) =>

                    new Wallet()
                    ));

                  },

                ),

                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Log out"),


                ),


              ],
            ),


          );

        }
        else
          {
            return Text("No data");
          }


      }
    );
  }
}


