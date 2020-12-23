import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/services.dart';
import 'package:on_canteen/classes/region.dart';
import 'package:on_canteen/network/regionsList.dart';
import 'package:on_canteen/screens/QAScreen.dart';
import 'package:on_canteen/screens/askQuestionScreen.dart';
import 'package:on_canteen/screens/auth/forgotPass.dart';
import 'package:on_canteen/screens/auth/login.dart';
import 'package:on_canteen/screens/auth/newPass.dart';
import 'package:on_canteen/screens/auth/registration.dart';
import 'package:on_canteen/screens/auth/confirmationCode.dart';
import 'package:on_canteen/screens/buffetItemScreen.dart';
import 'package:on_canteen/screens/buffetScreen.dart';
import 'package:on_canteen/screens/foodsListScreen.dart';
import 'package:on_canteen/screens/institutionTypesScreen.dart';
import 'package:on_canteen/screens/menuListScreen.dart';
import 'package:on_canteen/screens/institutionWeekScreen.dart';
import 'package:on_canteen/screens/institutionsScreen.dart';
import 'package:on_canteen/screens/singleFoodScreen.dart';
import 'classes/authClasses.dart';
import 'package:on_canteen/network/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

LogOut signOut;
AddTokenClass addTokenIns;

class SecItem {
  SecItem(this.key, this.value);

  final String key;
  final String value;

  String get tokenKey => key;
  String get tokenValue => value;
}

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fraction(1 / 2),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'On Canteen',
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          InstitutionTypesScreen.id: (context) => InstitutionTypesScreen(),
          InstitutionsScreen.id: (context) => InstitutionsScreen(),
          InstitutionWeekScreen.id: (context) => InstitutionWeekScreen(),
          MenuListScreen.id: (context) => MenuListScreen(),
          FoodsListScreen.id: (context) => FoodsListScreen(),
          SingleFoodScreen.id: (context) => SingleFoodScreen(),
          AskQuestionScreen.id: (context) => AskQuestionScreen(),
          QAScreen.id: (context) => QAScreen(),
          BuffetScreen.id: (context) => BuffetScreen(),
          BuffetItemScreen.id: (context) => BuffetItemScreen(),
          ConfirmationCodeScreen.id: (context) => ConfirmationCodeScreen(),
          ForgotPassScreen.id: (context) => ForgotPassScreen(),
          NewPassScreen.id: (context) => NewPassScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.amber,
          highlightColor: Colors.transparent,
          // hintColor: Color(0xff979797),
          splashColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS:
                  CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
            },
          ),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _storage = FlutterSecureStorage();
  var tokenItems = [];

  delayer(context) async {
    try {
      for (var i in tokenItems) {
        if (i.tokenKey == 'token') {
          Navigator.pushReplacementNamed(context, InstitutionTypesScreen.id,
              arguments: {'addToken': addNewItem, 'deleteAll': deleteAll});
          return;
        }
      }
      Navigator.pushReplacementNamed(context, LoginScreen.id,
          arguments: {'addToken': addNewItem, 'deleteAll': deleteAll});
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _readAll() async {
    final all = await _storage.readAll();
    if (mounted) {
      setState(() {
        tokenItems = all.keys
            .map((key) => SecItem(key, all[key]))
            .toList(growable: false);
        if (tokenItems.length > 0) {
          for (var item in tokenItems) {
            if (item.tokenKey == 'token') {
              tokenString = item.tokenValue;
            }
            if (item.tokenKey == 'refresh') {
              refreshTokenString = item.tokenValue;
            }
          }
        }
        return tokenItems;
      });
    }
  }

  void deleteAll() async {
    await _storage.deleteAll();
    _readAll();
  }

  void addNewItem(key1, value1) async {
    final String key = key1;
    final String value = value1;

    await _storage.write(key: key, value: value);
    _readAll();
  }

  void regions() async {
    var outcome = await Regions().getData();
    if (outcome != null) {
      List regionsList = outcome['data'];
      for (int i = 0; i < regionsList.length; i++) {
        mapOfRegions.addAll({
          regionsList[i]['id'].toInt(): Region(
              id: regionsList[i]['id'].toInt(),
              name: regionsList[i]['name'].toString(),
              deleted: regionsList[i]['deleted'])
        });
        listOfRegions.clear();
        for (var x in mapOfRegions.keys) {
          listOfRegions.add(mapOfRegions[x]);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    regions();
    signOut = LogOut(deleteAll: deleteAll);
    addTokenIns = AddTokenClass(addTokenClass: addNewItem);
    logOutInData = signOut.deleteAll;
    addTokenInData = addTokenIns.addTokenClass;
    _readAll();
    Timer(Duration(milliseconds: 2500), () {
      delayer(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Color(0xff22272B),
        padding: EdgeInsets.symmetric(horizontal: 85.w),
        child: Image.asset(
          "images/icon.png",
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
