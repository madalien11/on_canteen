import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/ingredientCard.dart';

class SingleFoodCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final List ingredients;
  SingleFoodCard({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.ingredients,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Card(
        color: Color(0xff2A2F33),
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                        color: Color(0xffFABF03),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Wrap(
                      children: [
                        for (String i in ingredients) IngredientCard(name: i)
                      ],
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400),
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
