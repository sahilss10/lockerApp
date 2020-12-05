import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locker_app/Models/TransactionModel.dart';
import 'package:locker_app/Models/UserModel.dart';
import 'package:locker_app/Models/WalletModel.dart';

class Database {

  final String uid, docId;
  Database({this.uid, this.docId});

  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('User');

 /* List<UserModel> _userSnapshot(QuerySnapshot qs) {
    return qs.documents.map((doc) {
      return UserModel(
          fname: doc.data()['fname'] ?? '',
          lname: doc.data()['lname'] ?? '',
          email: doc.data()['email'] ?? '',
          phoneNo: doc.data()['phone no'] ?? 0,
          aadharCard: doc.data()['aadharcard'] ?? '',
          panCard: doc.data()['pancard'] ?? '',

      );
    }).toList();
  }*/

  UserModel _userModel(DocumentSnapshot documentSnapshot){
    return UserModel(
      uid: uid,
      name: documentSnapshot.data()['displayName'],
      email: documentSnapshot.data()['email'],
      phoneNo: documentSnapshot.data()['phone'],
      photoUrl: documentSnapshot.data()['photoUrl'],
      //aadharCard: documentSnapshot.data()['aadharcard'],
      //panCard: documentSnapshot.data()['pancard'],

    );
  }

  TransactionModel _transactionModel(DocumentSnapshot documentSnapshot){

      return TransactionModel(

      billAmt: documentSnapshot.data()['billAmount'],
      duration: documentSnapshot.data()['duration'],
      startTime: documentSnapshot.data()['startTime'],
      endTime: documentSnapshot.data()['endTime'],
      qrCode: documentSnapshot.data()['qrCode'],
      lockerAdd: documentSnapshot.data()['lockerAdd'],
      lockerName: documentSnapshot.data()['lockerName'],
      lockerNo: documentSnapshot.data()['lockerNo'],
      paymentMethod: documentSnapshot.data()['paymentMethod'],
      uid: documentSnapshot.data()['uid'],
    );

  }

  WalletModel _walletModel(DocumentSnapshot documentSnapshot)
  {
    return WalletModel(
      balance: documentSnapshot.data()['balance']
    );
  }

  Stream<UserModel> get userData {
    return userCollection.document(uid).snapshots().map(_userModel);
  }

  Stream<TransactionModel> get transactionData {
    return (userCollection.document(uid).collection('Transaction').document(docId).snapshots()).map(_transactionModel);
  }

  Stream<WalletModel> get walletData{
    return userCollection.document(uid).collection('Wallet').document('balance').snapshots().map(_walletModel);
  }

}