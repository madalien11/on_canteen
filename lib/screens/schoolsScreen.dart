import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/customCard.dart';
import 'package:on_canteen/components/institutionCard.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/screens/schoolWeekScreen.dart';

class SchoolsScreen extends StatefulWidget {
  static const String id = 'schools_screen';
  @override
  _SchoolsScreenState createState() => _SchoolsScreenState();
}

class _SchoolsScreenState extends State<SchoolsScreen> {
  bool cardDisabled = false;

  @override
  void initState() {
    super.initState();
    cardDisabled = false;
  }

  @override
  void dispose() {
    super.dispose();
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
            'Школы',
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
        child: Align(
          alignment: Alignment.topCenter,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      Navigator.pushNamed(context, SchoolWeekScreen.id);
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Школа №178',
                    onTap: () {
                      print('school');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
