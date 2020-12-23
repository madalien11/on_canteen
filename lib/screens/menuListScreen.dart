import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/classes/menu.dart';
import 'package:on_canteen/components/customCard.dart';
import 'package:on_canteen/network/data.dart';
import 'foodsListScreen.dart';
import 'institutionTypesScreen.dart';
import 'institutionWeekScreen.dart';

class MenuListScreen extends StatefulWidget {
  static const String id = 'menuList_screen';
  @override
  _MenuListScreenState createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  Future<List<Menu>> futureMenus;
  bool cardDisabled = false;
  String pageName = '';

  @override
  void initState() {
    super.initState();
    futureMenus = fetchMenus(context, chosenInstitutionId, chosenDayId);
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
    final Map map = ModalRoute.of(context).settings.arguments;
    if (map != null && map['pageName'] != null) pageName = map['pageName'];
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
            pageName.toString(),
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
            child: FutureBuilder<List<Menu>>(
              future: futureMenus,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomCard(
                        id: snapshot.data[index].id,
                        title: snapshot.data[index].name,
                        // isFood: false,
                        // isBuffet: true,
                        // isBuffetItem: true,
                        foodSubtitle: snapshot.data[index].description,
                        onTap: () {
                          if (!mounted) return;
                          setState(() {
                            cardDisabled = true;
                          });
                          Navigator.pushNamed(context, FoodsListScreen.id);
                          if (!mounted) return;
                          setState(() {
                            cardDisabled = false;
                          });
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Список пуст".toUpperCase(),
                    style: TextStyle(
                        color: Color(0xffFABF03),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ));
                }
                // By default, show a loading spinner.
                return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffFABF03))));
              },
            ),
          ),
        ),
      ),
    );
  }
}
