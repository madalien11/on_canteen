import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String detail, Function onPressed,
    {bool questionSent = false}) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: onPressed,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: questionSent
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xffFABF03),
                size: 100,
              ),
              Text(
                'Отправлено!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff2B3859),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 4),
              Text(
                detail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff2B3859),
                ),
              ),
            ],
          )
        : Text(detail),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
