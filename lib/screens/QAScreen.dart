import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/QACard.dart';
import 'package:on_canteen/components/showAlertDialog.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/components/myTextField.dart';
import 'package:on_canteen/components/myButton.dart';

class QAScreen extends StatefulWidget {
  static const String id = 'QA_screen';
  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  bool _isLoading;
  bool showAnswer;

  @override
  void initState() {
    super.initState();
    showAnswer = false;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff22272B),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
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
                            Text(
                              'Вопрос - Ответ',
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              'Найдите ответ на ваш вопрос',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      QACard(
                        question: 'Какой то вопрос будет?',
                        answer:
                            'Салат из свежих огурцов и помидоров  с авокадо Салат из свежих огурцов и помидоров  с авокадо Салат из свежих огурцов и помидоров  с авокадо Салат из свежих огурцов и помидоров  с авокадо Салат из свежих огурцов и помидоров  с авокадо',
                        onTap: () {
                          setState(() {
                            showAnswer = !showAnswer;
                          });
                        },
                        showAnswer: showAnswer,
                      ),
                      QACard(question: 'Какой то вопрос будет?', onTap: null),
                      QACard(question: 'Какой то вопрос будет?', onTap: null),
                    ],
                  ),
                ),
              ],
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
