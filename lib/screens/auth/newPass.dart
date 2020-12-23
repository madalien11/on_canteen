import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/network/data.dart';
import 'confirmationCode.dart';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';

import 'login.dart';

class NewPassScreen extends StatefulWidget {
  static const String id = 'newPass_screen';

  @override
  _NewPassScreenState createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final _passTextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();
  String _password;
  String _confirmPassword;

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
    Map map = ModalRoute.of(context).settings.arguments;
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
                          'Новый пароль',
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
                                title: 'новый ПАРОЛЬ',
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
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              child: MyButton(
                                isButtonDisabled: _isButtonDisabled,
                                onPressed: () async {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginScreen.id,
                                      (Route<dynamic> route) => false,
                                      arguments: {'addToken': addTokenInData});
                                  return;
                                  if (!mounted) return;
                                  setState(() {
                                    _isLoading = true;
                                    _isButtonDisabled = true;
                                  });

                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (_passTextController.text.isNotEmpty &&
                                      _confirmPassTextController
                                          .text.isNotEmpty) {
                                    try {
                                      final response = await ForgotPasswordData(
                                              email: map['email'],
                                              confPass: _password,
                                              newPass: _confirmPassword)
                                          .validate();
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
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              LoginScreen.id,
                                              (Route<dynamic> route) => false,
                                              arguments: {
                                                'addToken': addTokenInData
                                              });
                                        });
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
                                title: 'ОТПРАВИТЬ',
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
