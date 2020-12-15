import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/BuffetItemTypes.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/customCard.dart';
import 'package:on_canteen/network/data.dart';
import 'buffetItemScreen.dart';
import 'institutionTypesScreen.dart';

int chosenBuffetItemTypeId = 2;

class BuffetScreen extends StatefulWidget {
  static const String id = 'buffet_screen';
  @override
  _BuffetScreenState createState() => _BuffetScreenState();
}

class _BuffetScreenState extends State<BuffetScreen> {
  Future<List<BuffetItemTypes>> futureBuffetItemTypesList;
  bool cardDisabled = false;

  @override
  void initState() {
    super.initState();
    futureBuffetItemTypesList =
        fetchBuffetItemTypes(context, chosenInstitutionId);
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
            'Буфет',
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
            child: FutureBuilder<List<BuffetItemTypes>>(
              future: futureBuffetItemTypesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomCard(
                        id: snapshot.data[index].id,
                        title: snapshot.data[index].name,
                        isFood: false,
                        isBuffet: true,
                        onTap: () {
                          if (!mounted) return;
                          setState(() {
                            cardDisabled = true;
                          });
                          chosenBuffetItemTypeId = snapshot.data[index].id;
                          Navigator.pushNamed(context, BuffetItemScreen.id,
                              arguments: {
                                'pageName': snapshot.data[index].name
                              });
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
                        color: Color(0xff222222),
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
