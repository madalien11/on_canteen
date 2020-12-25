import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/dateClass.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/components/weekDayCard.dart';
import 'package:on_canteen/network/data.dart';
import 'buffetScreen.dart';
import 'institutionTypesScreen.dart';
import 'institutionsScreen.dart';
import 'menuListScreen.dart';

int chosenDayId = 9;

class InstitutionWeekScreen extends StatefulWidget {
  static const String id = 'institutionWeek_screen';
  @override
  _InstitutionWeekScreenState createState() => _InstitutionWeekScreenState();
}

class _InstitutionWeekScreenState extends State<InstitutionWeekScreen> {
  Future<List<DateClass>> futureDates;
  String pageName = '';
  bool cardDisabled = false;

  String getShortName(String fullName) {
    String short = '';
    if (fullName.toLowerCase() == 'понедельник')
      short = 'Пн';
    else if (fullName.toLowerCase() == 'вторник')
      short = 'Вт';
    else if (fullName.toLowerCase() == 'среда')
      short = 'Ср';
    else if (fullName.toLowerCase() == 'четверг')
      short = 'Чт';
    else if (fullName.toLowerCase() == 'пятница')
      short = 'Пт';
    else if (fullName.toLowerCase() == 'суббота')
      short = 'Сб';
    else if (fullName.toLowerCase() == 'воскресенье') short = 'Вс';
    return short;
  }

  @override
  void initState() {
    super.initState();
    futureDates = fetchDates(context, chosenInstitutionId);
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
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, BuffetScreen.id);
                  },
                  child: Card(
                    color: Color(0xff2A2F33),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1517404215738-15263e9f9178?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Container(color: Color(0xff262626).withOpacity(0.46)),
                        Center(
                          child: Text(
                            'Буфет',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.only(top: 14.h),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: FutureBuilder<List<DateClass>>(
                      future: futureDates,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width ~/
                                            180,
                                    childAspectRatio: 170.w / 90.h),
                            itemBuilder: (context, index) {
                              return WeekDayCard(
                                id: snapshot.data[index].id,
                                name: getShortName(snapshot.data[index].name),
                                isToday: snapshot.data[index].today,
                                subtitle: snapshot.data[index].name,
                                onTap: () {
                                  if (!mounted) return;
                                  setState(() {
                                    cardDisabled = true;
                                  });
                                  chosenDayId = snapshot.data[index].id;
                                  Navigator.pushNamed(
                                      context, MenuListScreen.id,
                                      arguments: {
                                        'pageName': snapshot.data[index].name,
                                        'dayId': snapshot.data[index].id,
                                      });
                                  if (!mounted) return;
                                  setState(() {
                                    cardDisabled = false;
                                  });
                                },
                              );
                            },
                            itemCount: snapshot.data.length > 0
                                ? 7
                                : snapshot.data.length,
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
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xffFABF03))));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
