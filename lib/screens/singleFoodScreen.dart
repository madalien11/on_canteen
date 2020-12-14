import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/components/singleFoodCard.dart';

class SingleFoodScreen extends StatefulWidget {
  static const String id = 'singleFood_screen';
  @override
  _SingleFoodScreenState createState() => _SingleFoodScreenState();
}

class _SingleFoodScreenState extends State<SingleFoodScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 706), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xff22272B),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  'https://images.unsplash.com/photo-1517404215738-15263e9f9178?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
          Column(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 6,
                child: SingleFoodCard(
                  title: 'Паста “Болоньезе”',
                  price: '1000 тг',
                  ingredients: [
                    'Ingredient yeaaaah veeeeery veeeeeeeeeeeeeeery looong 1',
                    'short',
                    'Ingredient 3',
                    'Ingredient 4',
                    'Ingredient 5',
                    'Ingredient 5',
                    'Ingredient 5',
                    'Something',
                    'short',
                    'Something',
                  ],
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                ),
              ),
              Expanded(child: Container()),
            ],
          )
        ],
      ),
    );
  }
}
