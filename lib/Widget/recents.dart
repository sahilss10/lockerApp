import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/Transitions/FadeTransition.dart';
import 'package:locker_app/Widget/Rating.dart';

import 'package:locker_app/helper/supportMap.dart';
import 'package:locker_app/helper/helper_lists.dart';

class Recents extends StatefulWidget {
  @override
  State createState() => _RecentState();
}

class _RecentState extends State<Recents> {
 List<bool> selected = List.generate(recentList.length, (i) => true);



  @override
  Widget build(BuildContext context) {

    print(recentList.length.toString()+"            kkkkkkkkkkkk");

    return
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: selected.length,
          physics: BouncingScrollPhysics(),

          itemBuilder: (context, index) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24),
              child:
              GestureDetector(
              onTap: () => {

              setState(() {
                for(int i=0;i<selected.length;i++)
                  selected[i]=true;
               selected[index]=! selected[index];

              }),

              Navigator.push(context,FadeRoute(page: SupportMapView(recentList[index])))
              }

              ,

              child:
              Card(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 6,
                  color: selected[index] ? Colors.indigo[500] : Colors.indigo[300],
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                recentList[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.4,
                                  letterSpacing: 0.2,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                recentList[index].subtitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                ),

                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: <Widget>[
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.lock_open_outlined,
                                        size: 16,
                                        color: recentList[index].availablelockers=="0"? Colors.red:Colors.green,

                                      ),
                                    ),
                                    color: Colors.grey[900],
                                    elevation: 4,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                     recentList[index].availablelockers.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 12.4),
                                  ),
                                  SizedBox(
                                    width: 20,
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
                                   recentList[index].price+' rs/h',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.4,
                                      color: Colors.white,),

                                  )
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top:10),
                                child: Container(

                                  width: MediaQuery.of(context).size.width/2,
                                  child: StarRating(
                                    size: 20,
                                    color: Colors.yellow[600],
                                    rating: recentList[index].rating,
                                  ),
                                ),
                              ),
                            ],

                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 10),
                          child: Container(
                          child: ClipRRect(
                            child:   Image.network(recentList[index].image,
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width/4,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            );
          }
      );
  }
}
