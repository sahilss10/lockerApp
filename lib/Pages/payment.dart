import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:locker_app/Pages/transaction_commit.dart';
import 'package:locker_app/Transitions/ScaleTransition.dart';
import 'package:locker_app/Widget/BottomSheet.dart';
import 'package:locker_app/helper/helper_lists.dart';
import 'package:locker_app/helper/LOCKERS_data.dart';
import 'package:locker_app/Pages/recipt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:locker_app/helper/supportMap.dart';
import 'package:locker_app/helper/locker_data.dart';
import 'package:locker_app/services/payment_service.dart';

class MyPaymentPage extends StatefulWidget {
  Struct locker;
  MyPaymentPage(this.locker);
  @override
  State createState() => _MyPaymentPageState(locker);
}

class _MyPaymentPageState extends State<MyPaymentPage> {
  _MyPaymentPageState(this.locker);
  List _paymentMethod = ['Google Pay', 'Bank Card', 'Cash', 'Amazon Pay'];
  static List<bool> selected = List.generate(4, (i) => i == 0 ? false : true);
  static List<bool> select = List.generate(4, (i) => i == 0 ? false : true);

  //lockers=List.generate(lockerList.length, (i) => lockerList[i].availability ? true : false);
  ////    1  ->  Available   2  ->   Booked    3-> selected
  String lockerNo = "XX-00";
  String qrcode = "";

  Struct locker;
  int no;
  int total = 0;
  dynamic type = "cash";
  int time = 0;
  String dateAndTime = "";
  String address = "";
  bool but = false;
  DateTime date;
  final dateFormat = DateFormat("d MMMM yyyy 'at' h:mm:s a");

  @override
  void initState() {
    lockers = List.generate(
        lockerList.length, (i) => lockerList[i].available ? true : false);
    print(lockerList.length.toString() + "  total lockerList in college");
    print(lockers.length.toString() + "  total lockers in college");
    super.initState();
  }

  Future getLockerData() async {
    print(lockerList.length.toString() + "  total lockerList in college");
    print(lockers.length.toString() + "  total lockers in college");

    return lockerList;
  }

  getColor(index) {
    try {
      if (lockers[index] == 1)
        return Colors.blue[100];
      else if (lockers[index] == 2)
        return Colors.red;
      else
        return Colors.indigo[300];
    } catch (RangeError) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[500],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupportMapView(locker),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  locker.title,
                  style: TextStyle(
                    fontSize: 34.4,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  locker.subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[200],
                  ),
                ),
                //////

                SizedBox(
                  height: 25,
                ),

                Text(
                  'Locker Time',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[200],
                      fontSize: 14.4),
                ),
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: SizedBox(
                    height: 104,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  for (int i = 0; i < selected.length; i++)
                                    selected[i] = true;
                                  selected[index] = !selected[index];
                                  time = index + 1;
                                  total = (index + 1) * int.parse(locker.price);
                                  print(total);
                                }),
                              },
                              child: Card(
                                elevation: 2,
                                color: selected[index]
                                    ? Colors.grey[300]
                                    : Colors.indigo[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 134,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${index + 1} hours',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 0.1),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '\u20B9 ${(index + 1) * int.parse(locker.price)}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[500]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Text(
                  'Payment Type',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[200],
                      fontSize: 14.4),
                ),

                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: SizedBox(
                    height: 104,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  for (int i = 0; i < select.length; i++)
                                    select[i] = true;
                                  select[index] = !select[index];
                                  type = _paymentMethod[index];
                                }),
                              },
                              child: Card(
                                elevation: 2,
                                color: select[index]
                                    ? Colors.grey[300]
                                    : Colors.indigo[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 134,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${_paymentMethod[index]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 0.1),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '${index}% GST',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[500]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select Locker',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[200],
                      fontSize: 14.4),
                ),

                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                        future: getLockerData(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            itemCount:
                                lockerList != null ? lockerList.length : 0,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: lockerList[index].available
                                    ? () {
                                        print(lockerList.length.toString() +
                                            "  gesture total lockerList in college");
                                        print(lockers.length.toString() +
                                            "   gesture total lockers in college");
                                        print(lockerList[index].toString());
                                        setState(() {
                                          lockers = List.generate(
                                              lockerList.length,
                                              (i) => lockerList[i].available
                                                  ? true
                                                  : false);

                                          lockers[index] = !lockers[index];

                                          lockerNo = locker.title +
                                              " " +
                                              lockerList[index]
                                                  .lockerNO
                                                  .toString();
                                          qrcode = lockerList[index].qrcode;
                                        no= lockerList[index]
                                              .lockerNO;
                                          address = locker.title +
                                              " - " +
                                              locker.subtitle;
                                        });
                                      }
                                    : null,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 6,
                                  color: lockerList[index].available
                                      ? lockers[index]
                                          ? Colors.grey[300]
                                          : Colors.indigo[300]
                                      : Colors.redAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, top: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          locker.title +
                                              " " +
                                              lockerList[index]
                                                  .lockerNO
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 0.1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ),

                SizedBox(
                  height: 25,
                ),
                Text(
                  'Select Time & Date',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[200],
                      fontSize: 14.4),
                ),

                AlertDialog(
                  contentPadding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: DateTimePickerFormField(
                      editable: false,
                      initialDate: DateTime.now(),
                      initialTime: new TimeOfDay(
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute),

                      firstDate: DateTime.now(),
                      dateOnly: false,
                      format: dateFormat,
                      //  decoration: InputDecoration(labelText: 'Date',),
                      onChanged: (dt) => setState(() {
                        date = dt;
                        dateAndTime = dateFormat.format(date);
                        print(date.toString());
                      }),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Container(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                ),

            Text(
              'Order summary',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[900],
                  fontSize: 14.4),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Container(
                height: 1,
                color: Colors.grey[200],
              ),
            ),


                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Total : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.4,
                                      letterSpacing: 0.2),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$total',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.2),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '$type',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Lease Time : $time',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        letterSpacing: 0.2),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Locker No : " + lockerNo,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Rented from : ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '$dateAndTime',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2),
                            ),
                          ),



                SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: RaisedButton(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              ScaleRoute(
                                  page: MyTransactionCommit(
                                      new PaymentTransaction(
                                          total,
                                          time,
                                          qrcode,
                                          address,
                                          lockerNo,
                                          type,
                                          date,
                                          no,
                                        date.subtract(new Duration(hours: time)),)
                                  )
                              )
                          );
                        },
                        color: Colors.indigo[900],
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'PAY NOW',
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              wordSpacing: 4,
                              letterSpacing: 0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
