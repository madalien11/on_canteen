import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekDayCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final bool isToday;
  WeekDayCard({
    @required this.title,
    @required this.onTap,
    @required this.subtitle,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80.h,
        width: 170.w,
        margin: EdgeInsets.all(2.w),
        child: Card(
          color: isToday ? Color(0xffFFEBAB) : Color(0xffFABF03),
          elevation: 10,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color(0xffFABF03), style: BorderStyle.solid, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isToday ? Color(0xffFABF03) : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp,
                  shadows: isToday
                      ? []
                      : <Shadow>[
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                            color: Color.fromARGB(120, 0, 0, 0),
                          ),
                        ],
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: isToday ? Color(0xffFABF03) : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  shadows: isToday
                      ? []
                      : <Shadow>[
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                            color: Color.fromARGB(100, 0, 0, 0),
                          ),
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
