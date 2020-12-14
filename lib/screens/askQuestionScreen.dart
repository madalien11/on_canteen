import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';

class AskQuestionScreen extends StatefulWidget {
  static const String id = 'askQuestion_screen';

  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final _phoneNumTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _questionTextController = TextEditingController();

  String _phoneNum;
  String _name;
  String _question;

  bool checkedValue = false;
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
                        centralWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Вопрос Диетологу',
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              'Задайте свой вопрос, и получите ответ в течении 24 часов',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: MyRow(
                      myCrossAxisAlignment: CrossAxisAlignment.start,
                      centralFlex: 20,
                      centralWidget: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 10.h),
                              Container(
                                height: 84.h,
                                child: MyTextField(
                                  myController: _nameTextController,
                                  onChanged: (value) {
                                    _name = value;
                                  },
                                  title: 'ваше имя',
                                  isWhite: true,
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
                                  title: 'Ваш Номер',
                                  isWhite: true,
                                  myPrefixIcon: Icon(
                                    Icons.phone,
                                    color: Color(0xff979797),
                                  ),
                                ),
                              ),
                              Container(
                                height: 150.h,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Spacer(),
                                    Text(
                                      'Ваш Вопрос'.toUpperCase(),
                                      style: TextStyle(
                                          color: Color(0xff979797),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    TextFormField(
                                      controller: _questionTextController,
                                      onChanged: (str) {
                                        _question = str;
                                      },
                                      minLines: 5,
                                      maxLines: 7,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 20, 12, 12),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffFABF03),
                                              width: 1.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 50.h, bottom: 20.h),
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
                                    if (_nameTextController.text.isNotEmpty &&
                                        _questionTextController
                                            .text.isNotEmpty &&
                                        _phoneNumTextController
                                            .text.isNotEmpty) {
                                      setState(() {
                                        showAlertDialog(context,
                                            'Ожидайте ответ в течении 24 часов',
                                            () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          Navigator.pop(context);
                                        }, questionSent: true);
                                      });
                                    } else {
                                      setState(() {
                                        showAlertDialog(context,
                                            'Please, fill in the fields', () {
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
                                  title: 'Отправить',
                                ),
                              ),
                            ],
                          ),
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
