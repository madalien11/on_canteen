import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    FilteringTextInputFormatter.allow(RegExp(r'^([8])|([7])$')),
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
