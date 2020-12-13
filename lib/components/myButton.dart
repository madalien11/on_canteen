import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final bool isButtonDisabled;
  final String title;
  MyButton({
    @required this.onPressed,
    @required this.isButtonDisabled,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return FlatButton(
        onPressed:
            isButtonDisabled ? () => print('Button is disabled') : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Color(0xffFABF03),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xff2A2F33),
              letterSpacing: -0.3),
        ));
  }
}
