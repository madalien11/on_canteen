import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/Institution.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/classes/dietolog.dart';
import 'package:on_canteen/components/institutionCard.dart';
import 'package:on_canteen/components/myButton.dart';
import 'package:on_canteen/network/data.dart';
import 'package:on_canteen/screens/askQuestionScreen.dart';
import 'package:on_canteen/screens/institutionsScreen.dart';
import 'QAScreen.dart';
import 'auth/login.dart';

int chosenInstitutionId = 2;

class InstitutionTypesScreen extends StatefulWidget {
  static const String id = 'institutionTypes_screen';
  @override
  _InstitutionTypesScreenState createState() => _InstitutionTypesScreenState();
}

class _InstitutionTypesScreenState extends State<InstitutionTypesScreen> {
  Future<List<Institution>> futureInstitutionsList;
  Future<List<Dietolog>> futureDietolog;
  bool firstButtonDisabled = false;
  bool secondButtonDisabled = false;
  bool cardDisabled = false;

  @override
  void initState() {
    super.initState();
    futureInstitutionsList = fetchInstitutionTypes(context);
    futureDietolog = fetchDietolog(context);
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
    final Map map = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xff22272B),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (logOutInData != null) {
                    logOutInData();
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,
                        (Route<dynamic> route) => false,
                        arguments: {'addToken': addTokenInData});
                  } else if (map != null && map['deleteAll'] != null) {
                    map['deleteAll']();
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,
                        (Route<dynamic> route) => false,
                        arguments: {'addToken': map['addToken']});
                  }
                }),
          )
        ],
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
                  child: FutureBuilder<List<Institution>>(
                    future: futureInstitutionsList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).size.width ~/ 180),
                          itemBuilder: (context, index) {
                            return InstitutionCard(
                              id: snapshot.data[index].id,
                              name: snapshot.data[index].name,
                              onTap: () {
                                if (!mounted) return;
                                setState(() {
                                  cardDisabled = true;
                                });
                                chosenInstitutionId = snapshot.data[index].id;
                                Navigator.pushNamed(
                                    context, InstitutionsScreen.id, arguments: {
                                  'pageName': snapshot.data[index].name
                                });
                                if (!mounted) return;
                                setState(() {
                                  cardDisabled = false;
                                });
                              },
                              isDisabled: cardDisabled,
                            );
                          },
                          itemCount: snapshot.data.length,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          "Список организации пуст".toUpperCase(),
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
                    FutureBuilder<List<Dietolog>>(
                      future: futureDietolog,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30.h,
                              backgroundImage: AssetImage('images/icon.png'),
                            ),
                            title: Text(
                              snapshot.data[0].name +
                                  ' ' +
                                  snapshot.data[0].surname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              snapshot.data[0].description,
                              style: TextStyle(
                                  color: Color(0xff979797),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "Список диетологов пуст".toUpperCase(),
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
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Вопросы - Ответы',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
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
