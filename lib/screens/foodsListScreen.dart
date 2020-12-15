import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/customCard.dart';
import 'package:on_canteen/components/institutionCard.dart';
import 'package:on_canteen/components/myRow.dart';
import 'package:on_canteen/screens/institutionWeekScreen.dart';
import 'package:on_canteen/screens/singleFoodScreen.dart';

class FoodsListScreen extends StatefulWidget {
  static const String id = 'foodsList_screen';
  @override
  _FoodsListScreenState createState() => _FoodsListScreenState();
}

class _FoodsListScreenState extends State<FoodsListScreen> {
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
            'Меню 1',
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
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                      Navigator.pushNamed(context, SingleFoodScreen.id);
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  CustomCard(
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  CustomCard(
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  CustomCard(
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  CustomCard(
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  CustomCard(
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  CustomCard(
                    title: 'Салат из авокадо',
                    onTap: () {
                      print('food');
                    },
                    isFood: true,
                    foodSubtitle: '450 Ккал',
                    price: '1000 тг',
                  ),
                  SizedBox(height: 20.h, width: double.infinity),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
