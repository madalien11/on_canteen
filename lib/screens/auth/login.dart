import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/network/data.dart';
import 'package:on_canteen/screens/institutionTypesScreen.dart';
import 'registration.dart';
import 'dart:convert';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumTextController = TextEditingController();
  final _passTextController = TextEditingController();
  bool checkedValue = false;
  String _phoneNum;
  String _password;
  bool _hidePass;
  bool _isButtonDisabled;
  bool _isLoading;

  void onPressed() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _isButtonDisabled = true;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_passTextController.text.isNotEmpty &&
        _phoneNumTextController.text.isNotEmpty) {
      dynamic outcome =
          await Login(phoneNum: _phoneNum, password: _password).login();
      String source = Utf8Decoder().convert(outcome.bodyBytes);
      print(source);
      if (outcome.statusCode == 401) {
        if (!mounted) return;
        setState(() {
          showAlertDialog(context, jsonDecode(source)['detail'], () {
            Navigator.pop(context);
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
          });
          _isLoading = false;
          _isButtonDisabled = false;
        });
      } else if (outcome.statusCode == 200) {
        dynamic userInfo = jsonDecode(source);
        tokenString = userInfo['access'];
        refreshTokenString = userInfo['refresh'];
        if (checkedValue) {
          if (addTokenInData != null) {
            addTokenInData('token', userInfo['access'].toString());
            addTokenInData('refresh', userInfo['refresh'].toString());
            addTokenInData('name', userInfo['data']['username'].toString());
            // Navigator.pushReplacementNamed(
            //     context, SchoolsScreen.id,
            //     arguments: {
            //       'addToken':
            //       addTokenInData,
            //       'deleteAll': logOutInData,
            //       'checkedValue':
            //       checkedValue
            //     });
          }
        } else {
          // Navigator.pushReplacementNamed(
          //     context, SchoolsScreen.id,
          //     arguments: {
          //       'checkedValue': checkedValue
          //     });
        }
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _isButtonDisabled = false;
        });
        _phoneNumTextController.clear();
        _passTextController.clear();
      }
    } else {
      if (!mounted) return;
      setState(() {
        showAlertDialog(context, 'Email and/or password cannot be empty', () {
          Navigator.pop(context);
          if (!mounted) return;
          setState(() {
            _isLoading = false;
          });
        });
        _isLoading = false;
        _isButtonDisabled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _hidePass = true;
    _isLoading = false;
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xffFDFDFD),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              color: Color(0xff22272B),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.yellow[700],
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: MyRow(
                          myCrossAxisAlignment: CrossAxisAlignment.end,
                          centralFlex: 20,
                          centralWidget: Text(
                            'Вход',
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
                    flex: 2,
                    child: MyRow(
                      centralFlex: 20,
                      centralWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child: Container()),
                          Expanded(
                            flex: 12,
                            child: MyTextField(
                              title: 'Номер телефона',
                              myKeyboardType: TextInputType.phone,
                              myController: _phoneNumTextController,
                              onChanged: (value) {
                                _phoneNum = value;
                              },
                              myPrefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xff979797),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Expanded(
                            flex: 12,
                            child: MyTextField(
                              title: 'пароль',
                              myController: _passTextController,
                              myObscureText: _hidePass,
                              onChanged: (value) {
                                _password = value;
                              },
                              myPrefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xff979797),
                              ),
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
                                        color: Color(0xff979797),
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Color(0xff979797),
                                      ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 12,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 35.w,
                                    height: 35.h,
                                    child: Transform.scale(
                                      scale: 0.85,
                                      child: Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor: Colors
                                              .orangeAccent
                                              .withOpacity(0.85),
                                        ),
                                        child: Checkbox(
                                          checkColor: Color(
                                              0xffFABF03), // color of tick Mark
                                          activeColor: Color(0xff979797),
                                          value: checkedValue,
                                          onChanged: (newValue) {
                                            if (!mounted) return;
                                            setState(() {
                                              checkedValue = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Запомнить меня',
                                    style: TextStyle(
                                      color:
                                          Color(0xffFABF03).withOpacity(0.75),
                                      fontSize: 12.sp,
                                      letterSpacing: -0.33,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: FlatButton(
                                        onPressed: () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          // Navigator.pushNamed(
                                          //     context, ForgotPasswordScreen.id);
                                        },
                                        child: Text(
                                          'Забыли Пароль?',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 12.sp,
                                            color: Color(0xffFABF03)
                                                .withOpacity(0.75),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: MyButton(
                              title: 'ВХОД',
                              isButtonDisabled: _isButtonDisabled,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, InstitutionTypesScreen.id);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 28,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: FlatButton(
                                    onPressed: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      Navigator.pushNamed(
                                          context, RegistrationScreen.id);
                                    },
                                    child: Text(
                                      'Зарегистрироваться',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          letterSpacing: -0.3),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffEFA921))))
              : Container()
        ],
      ),
    );
  }
}
