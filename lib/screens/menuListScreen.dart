import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/customCard.dart';
import 'package:on_canteen/components/institutionCard.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/screens/foodsListScreen.dart';
import 'package:on_canteen/screens/schoolWeekScreen.dart';

class MenuListScreen extends StatefulWidget {
  static const String id = 'menuList_screen';
  @override
  _MenuListScreenState createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            'Понедельник',
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
                    title: 'Меню 1',
                    onTap: () {
                      Navigator.pushNamed(context, FoodsListScreen.id);
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Меню 2',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Завтрак',
                    onTap: () {
                      print('school');
                    },
                  ),
                  CustomCard(
                    title: 'Обед',
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
