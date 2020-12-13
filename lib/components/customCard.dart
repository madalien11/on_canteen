import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String foodSubtitle;
  final String price;
  final Function onTap;
  final bool isFood;
  CustomCard({
    @required this.title,
    @required this.onTap,
    this.isFood = false,
    this.foodSubtitle = '',
    this.price = '1000 тг',
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isFood ? 100.h : 90.h,
        margin: isFood
            ? EdgeInsets.symmetric(horizontal: 8.w)
            : EdgeInsets.all(8.w),
        child: Card(
            margin: isFood
                ? EdgeInsets.symmetric(horizontal: 4.0)
                : EdgeInsets.all(4.0),
            color: Color(0xff2A2F33),
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: isFood
                    ? BorderRadius.all(Radius.circular(0))
                    : BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xffFABF03),
                radius: 30.h,
                child: Icon(
                  Icons.account_balance_sharp,
                  color: Color(0xff2A2F33),
                  size: 30.h,
                ),
                // backgroundImage: AssetImage('images/icon.png'),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  color: Color(0xffFABF03)),
              title: isFood
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffF2F2F2)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            foodSubtitle,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              price,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFABF03)),
                            ),
                          ),
                        )
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffF2F2F2)),
                    ),
              subtitle: isFood
                  ? null
                  : Text(
                      'Short Description',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
            ))),
      ),
    );
  }
}
