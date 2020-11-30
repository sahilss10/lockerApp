import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  IconData _icon;
  String _space;

  CustomMarker(this._icon, this._space);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26),
          child: Center(
            child: Icon(
              Icons.location_on,
              color: Colors.indigo[500],
            ),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.indigo[500],
              borderRadius: BorderRadius.circular(4.4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                _icon,
                size: 13.4,
                color: Colors.white,
              ),
              Text(
                '$_space',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        )
      ],
    );
  }
}


class MeMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.indigo.withOpacity(0.1),
        ),
        Center(
          child: CircleAvatar(
            radius: 5,
            backgroundColor: Colors.indigo,
          ),
        )
      ],
    );
  }
}
