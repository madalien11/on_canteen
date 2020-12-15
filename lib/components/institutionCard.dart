import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/components/myRow.dart';

class InstitutionCard extends StatelessWidget {
  final int id;
  final String name;
  final Function onTap;
  final bool isDisabled;
  InstitutionCard(
      {@required this.id,
      @required this.name,
      @required this.isDisabled,
      @required this.onTap});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return InkWell(
      onTap: isDisabled ? () => print('Card is disabled') : onTap,
      child: Container(
        height: 160.h,
        width: 160.w,
        margin: EdgeInsets.all(5.w),
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff2A2F33),
                ),
              ),
              MyRow(
                centralFlex: 10,
                centralWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffFABF03),
                        radius: 30.h,
                        child: Icon(
                          Icons.account_balance_sharp,
                          color: Color(0xff2A2F33),
                          size: 30.h,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(name.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text('Short Description',
                          style: TextStyle(
                              color: Color(0xff818689).withOpacity(0.74),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400)),
                    ),
                    Expanded(child: Container()),
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
