import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String validateMobile(String value) {
  // +7777 777 77 77 or 8777 777 77 77
  String pattern = r'(^([+7][7][0-9]{10}|[8][7][0-9]{9})$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return 'Пожалуйста, введите ваш номер';
  } else if (!regExp.hasMatch(value)) {
    return 'Пожалуйста, введите правильный номер';
  }
  return null;
}

class MyTextField extends StatelessWidget {
  final TextEditingController myController;
  final TextInputType myKeyboardType;
  final Function onChanged;
  final Icon myPrefixIcon;
  final bool myObscureText;
  final bool isWhite;
  final Widget mySuffixIcon;
  final String title;
  MyTextField(
      {@required this.myController,
      this.myKeyboardType,
      @required this.onChanged,
      @required this.title,
      @required this.myPrefixIcon,
      this.myObscureText = false,
      this.isWhite = false,
      this.mySuffixIcon});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    Pattern pattern = r'(^([+7][7][0-9]{10}|[8][7][0-9]{9})$)';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
        Text(
          title.toUpperCase(),
          style: TextStyle(
              color: Color(0xff979797),
              fontSize: 13.sp,
              fontWeight: FontWeight.w700),
        ),
        Spacer(),
        Container(
          child: TextField(
            keyboardType:
                myKeyboardType != null ? myKeyboardType : TextInputType.text,
            autofocus: false,
            inputFormatters: myKeyboardType == TextInputType.phone
                ? <TextInputFormatter>[
                    // FilteringTextInputFormatter.allow(pattern),
                  ]
                : <TextInputFormatter>[],
            obscureText: myObscureText,
            controller: myController,
            onChanged: onChanged,
            style: TextStyle(
                color: isWhite ? Colors.black : Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.white,
              filled: isWhite,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isWhite ? Colors.white : Color(0xff979797),
                    width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffFABF03), width: 1.0),
              ),
              hintStyle: TextStyle(fontSize: 14.sp),
              prefixIcon: isWhite ? null : myPrefixIcon,
              suffixIcon: mySuffixIcon != null ? mySuffixIcon : null,
            ),
          ),
        ),
      ],
    );
  }
}
