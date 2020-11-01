import 'package:flutter/cupertino.dart';
import 'package:locker_app/CommonWidgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
        );
}
