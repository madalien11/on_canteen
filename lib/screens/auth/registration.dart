import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/network/auth.dart';
// import 'package:plyushka/screens/user/enterCodeScreen.dart';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailTextController = TextEditingController();
  final _phoneNumTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();

  String _email;
  String _phoneNum;
  String _name;
  String _password;
  String _confirmPassword;
  String dropdownValue = 'One';

  bool checkedValue = false;
  bool _hidePass;
  bool _hideConfirmPass;
  bool _isButtonDisabled;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _hidePass = true;
    _isLoading = false;
    _isButtonDisabled = false;
    _hideConfirmPass = true;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xff22272B),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 15,
                  child: Container(
                    color: Colors.yellow[700],
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: MyRow(
                        myCrossAxisAlignment: CrossAxisAlignment.end,
                        centralFlex: 20,
                        centralWidget: Text(
                          'Регистрация',
                          style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: MyRow(
                    myCrossAxisAlignment: CrossAxisAlignment.start,
                    centralFlex: 20,
                    centralWidget: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20.h),
                            Container(
                              height: 84.h,
                              child: MyTextField(
                                myController: _nameTextController,
                                onChanged: (value) {
                                  _name = value;
                                },
                                title: 'Имя Фамилия',
                                myPrefixIcon: Icon(
                                  Icons.person_outline_outlined,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                            Container(
                              height: 84.h,
                              child: MyTextField(
                                myKeyboardType: TextInputType.phone,
                                myController: _phoneNumTextController,
                                onChanged: (value) {
                                  _phoneNum = value;
                                },
                                title: 'номер телефона',
                                myPrefixIcon: Icon(
                                  Icons.phone,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                            Container(
                              height: 84.h,
                              child: MyTextField(
                                myKeyboardType: TextInputType.emailAddress,
                                myController: _emailTextController,
                                onChanged: (value) {
                                  _email = value;
                                },
                                title: 'EMAIL',
                                myPrefixIcon: Icon(
                                  Icons.mail_outline_outlined,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                            Container(
                              height: 84.h,
                              child: MyTextField(
                                myController: _passTextController,
                                myObscureText: _hidePass,
                                onChanged: (value) {
                                  _password = value;
                                },
                                mySuffixIcon: IconButton(
                                  onPressed: () {
                                    if (!mounted) return;
                                    setState(() {
                                      _hidePass = !_hidePass;
                                    });
                                  },
                                  icon: _hidePass
                                      ? Icon(
                                          Icons.visibility,
                                          color: Color(0xff828282),
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Color(0xffEFA921),
                                        ),
                                ),
                                title: 'ПАРОЛЬ',
                                myPrefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                            Container(
                              height: 84.h,
                              child: MyTextField(
                                myController: _confirmPassTextController,
                                myObscureText: _hideConfirmPass,
                                onChanged: (value) {
                                  _confirmPassword = value;
                                },
                                mySuffixIcon: IconButton(
                                  onPressed: () {
                                    if (!mounted) return;
                                    setState(() {
                                      _hideConfirmPass = !_hideConfirmPass;
                                    });
                                  },
                                  icon: _hideConfirmPass
                                      ? Icon(
                                          Icons.visibility,
                                          color: Color(0xff979797),
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Color(0xff979797),
                                        ),
                                ),
                                title: 'ПОДТВЕРДИТЕ ПАРОЛЬ',
                                myPrefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                            Container(
                              height: 70.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Выберите Регион'.toUpperCase(),
                                    style: TextStyle(
                                        color: Color(0xff979797),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                        canvasColor: Color(0xff22272B)),
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.arrow_downward,
                                          color: Color(0xffEFA921)),
                                      iconSize: 20,
                                      elevation: 16,
                                      style:
                                          TextStyle(color: Color(0xffEFA921)),
                                      underline: Container(
                                        height: 2,
                                        color: Color(0xff979797),
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[
                                        'One',
                                        'Two',
                                        'Free',
                                        'Four'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              child: MyButton(
                                isButtonDisabled: _isButtonDisabled,
                                onPressed: () async {
                                  if (!mounted) return;
                                  setState(() {
                                    _isLoading = true;
                                    _isButtonDisabled = true;
                                  });
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (_emailTextController.text.isNotEmpty &&
                                      _nameTextController.text.isNotEmpty &&
                                      _passTextController.text.isNotEmpty &&
                                      _confirmPassTextController
                                          .text.isNotEmpty) {
                                    try {
                                      final response = await Registration(
                                              email: _email,
                                              username: _name,
                                              phoneNum: _phoneNum,
                                              password1: _password,
                                              password2: _confirmPassword)
                                          .register();
                                      if (response.statusCode >= 200 &&
                                          response.statusCode < 203) {
                                        String source = Utf8Decoder()
                                            .convert(response.bodyBytes);
                                        showAlertDialog(
                                            context,
                                            jsonDecode(source)['detail'] ??
                                                'null', () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          Navigator.pop(context);
                                          // Navigator.pushNamed(context, EnterCodeScreen.id,
                                          //     arguments: {'email': _email});
                                        });
                                        _nameTextController.clear();
                                        _emailTextController.clear();
                                        _passTextController.clear();
                                        _confirmPassTextController.clear();
                                      } else {
                                        setState(() {
                                          String source = Utf8Decoder()
                                              .convert(response.bodyBytes);
                                          showAlertDialog(
                                              context,
                                              jsonDecode(source)['detail'] ??
                                                  'Invalid username', () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            Navigator.pop(context);
                                          });
                                        });
                                      }
                                    } catch (e) {
                                      showAlertDialog(context, e.toString(),
                                          () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        Navigator.pop(context);
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      showAlertDialog(
                                          context, 'Please, fill in the fields',
                                          () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        Navigator.pop(context);
                                      });
                                    });
                                  }
                                  if (!mounted) return;
                                  setState(() {
                                    _isButtonDisabled = false;
                                    _isLoading = false;
                                  });
                                },
                                title: 'ЗАРЕГИСТРИРОВАТЬСЯ',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffFABF03))))
              : Container()
        ],
      ),
    );
  }
}
