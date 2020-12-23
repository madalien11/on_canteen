import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/network/data.dart';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';
import 'package:on_canteen/screens/auth/newPass.dart';
import 'login.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  static const String id = 'confirmationCode_screen';

  @override
  _ConfirmationCodeScreenState createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  final _codeTextController = TextEditingController();
  String _code;
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
                          'Подтверждение',
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
                                myController: _codeTextController,
                                onChanged: (value) {
                                  _code = value;
                                },
                                title: 'Код подтверждения',
                                myPrefixIcon: Icon(
                                  Icons.confirmation_num_outlined,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              child: MyButton(
                                isButtonDisabled: _isButtonDisabled,
                                onPressed: () async {
                                  map['fromRegistration']
                                      ? Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          LoginScreen.id,
                                          (Route<dynamic> route) => false,
                                          arguments: {
                                              'addToken': addTokenInData
                                            })
                                      : Navigator.pushNamed(
                                          context, NewPassScreen.id,
                                          arguments: {'email': map['email']});
                                  return;
                                  if (!mounted) return;
                                  setState(() {
                                    _isLoading = true;
                                    _isButtonDisabled = true;
                                  });
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (_codeTextController.text.isNotEmpty) {
                                    try {
                                      final response = await EmailConfirm(
                                              email: map['email'], code: _code)
                                          .confirm();
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
                                          map['fromRegistration']
                                              ? Navigator
                                                  .pushNamedAndRemoveUntil(
                                                      context,
                                                      LoginScreen.id,
                                                      (Route<dynamic> route) =>
                                                          false,
                                                      arguments: {
                                                      'addToken': addTokenInData
                                                    })
                                              : Navigator.pushNamed(
                                                  context, NewPassScreen.id,
                                                  arguments: {
                                                      'email': map['email']
                                                    });
                                        });
                                        _codeTextController.clear();
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
