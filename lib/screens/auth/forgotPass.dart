import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/network/data.dart';
import 'registrationCode.dart';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';

class ForgotPassScreen extends StatefulWidget {
  static const String id = 'forgotPass_screen';

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _emailTextController = TextEditingController();
  String _email;

  bool _isButtonDisabled;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _isButtonDisabled = false;
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
                          'Забыли Пароль?',
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
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              child: MyButton(
                                isButtonDisabled: _isButtonDisabled,
                                onPressed: () async {
                                  // Navigator.pushNamed(
                                  //     context, ForgotPassCodeScreen.id,
                                  //     arguments: {'email': _email});
                                  // return;
                                  if (!mounted) return;
                                  setState(() {
                                    _isLoading = true;
                                    _isButtonDisabled = true;
                                  });

                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (_emailTextController.text.isNotEmpty) {
                                    try {
                                      final response =
                                          await EmailValidate(email: _email)
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
                                          Navigator.pushNamed(context,
                                              RegistrationCodeScreen.id,
                                              arguments: {'email': _email});
                                        });
                                        _emailTextController.clear();
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
