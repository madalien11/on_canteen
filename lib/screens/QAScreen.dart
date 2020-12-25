import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/QAClass.dart';
import 'package:on_canteen/components/QACard.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/network/data.dart';

class QAScreen extends StatefulWidget {
  static const String id = 'QA_screen';
  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  Future<List<QAClass>> futureQAs;
  Map<int, bool> showAnswerMap = {};
  bool _isLoading;
  bool showAnswer;

  @override
  void initState() {
    super.initState();
    futureQAs = fetchQAs(context);
    showAnswer = false;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff22272B),
      body: Stack(
        children: <Widget>[
          Column(
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
                child: FutureBuilder<List<QAClass>>(
                  future: futureQAs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          showAnswerMap[snapshot.data[index].questionId] =
                              false;
                          return QACard(
                            question: snapshot.data[index].question,
                            answer: snapshot.data[index].answer,
                            name: snapshot.data[index].name,
                            phoneNum: snapshot.data[index].phoneNum,
                            answerId: snapshot.data[index].answerId,
                            questionId: snapshot.data[index].questionId,
                            showAnswerMap: showAnswerMap,
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        "Список вопросов пуст".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffFABF03),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ));
                    }
                    // By default, show a loading spinner.
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xffFABF03))));
                  },
                ),
              ),
            ],
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
