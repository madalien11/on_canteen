import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/institutionCard.dart';
import 'package:on_canteen/components/myButton.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/screens/askQuestionScreen.dart';
import 'package:on_canteen/screens/schoolsScreen.dart';

import 'QAScreen.dart';

class InstitutionsScreen extends StatefulWidget {
  static const String id = 'institutions_screen';
  @override
  _InstitutionsScreenState createState() => _InstitutionsScreenState();
}

class _InstitutionsScreenState extends State<InstitutionsScreen> {
  bool firstButtonDisabled = false;
  bool secondButtonDisabled = false;
  bool cardDisabled = false;

  @override
  void initState() {
    super.initState();
    firstButtonDisabled = false;
    secondButtonDisabled = false;
    cardDisabled = false;
  }

  @override
  void dispose() {
    super.dispose();
    firstButtonDisabled = false;
    secondButtonDisabled = false;
    cardDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xff22272B),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            'Учреждения',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              letterSpacing: 0.75,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 15,
              child: Align(
                alignment: Alignment.topCenter,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        InstitutionCard(
                            isDisabled: cardDisabled,
                            onTap: () {
                              if (!mounted) return;
                              setState(() {
                                cardDisabled = true;
                              });
                              Navigator.pushNamed(context, SchoolsScreen.id);
                              if (!mounted) return;
                              setState(() {
                                cardDisabled = false;
                              });
                            }),
                        InstitutionCard(isDisabled: cardDisabled, onTap: () {}),
                        InstitutionCard(isDisabled: cardDisabled, onTap: () {}),
                        InstitutionCard(isDisabled: cardDisabled, onTap: () {}),
                        InstitutionCard(isDisabled: cardDisabled, onTap: () {}),
                        InstitutionCard(isDisabled: cardDisabled, onTap: () {}),
                        InstitutionCard(isDisabled: cardDisabled, onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Card(
                color: Color(0xff2A2F33),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30.h,
                        backgroundImage: AssetImage('images/icon.png'),
                      ),
                      title: Text(
                        'Игорь Викторевич',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Диетолог',
                        style: TextStyle(
                            color: Color(0xff979797),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(thickness: 2, height: 0),
                    Row(children: [
                      Expanded(child: Container()),
                      Expanded(
                        flex: 20,
                        child: FlatButton(
                            onPressed: !firstButtonDisabled
                                ? () {
                                    if (!mounted) return;
                                    setState(() {
                                      firstButtonDisabled = true;
                                    });
                                    Navigator.pushNamed(context, QAScreen.id);
                                    if (!mounted) return;
                                    setState(() {
                                      firstButtonDisabled = false;
                                    });
                                  }
                                : () {
                                    print('Button is disabled');
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid),
                            ),
                            child: Text(
                              'Вопросы - Ответы',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                      ),
                      Expanded(child: Container()),
                      Expanded(
                        flex: 20,
                        child: MyButton(
                          title: 'Задать Вопрос',
                          onPressed: () {
                            if (!mounted) return;
                            setState(() {
                              secondButtonDisabled = true;
                            });
                            Navigator.pushNamed(context, AskQuestionScreen.id);
                            if (!mounted) return;
                            setState(() {
                              secondButtonDisabled = false;
                            });
                          },
                          isButtonDisabled: secondButtonDisabled,
                        ),
                      ),
                      Expanded(child: Container()),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
