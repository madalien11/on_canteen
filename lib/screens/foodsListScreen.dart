import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_canteen/classes/deleteGlow.dart';
import 'package:on_canteen/classes/food.dart';
import 'package:on_canteen/components/customCard.dart';
import 'package:on_canteen/network/data.dart';
import 'package:on_canteen/screens/menuListScreen.dart';
import 'package:on_canteen/screens/singleFoodScreen.dart';

int chosenFoodId = 1;

class FoodsListScreen extends StatefulWidget {
  static const String id = 'foodsList_screen';
  @override
  _FoodsListScreenState createState() => _FoodsListScreenState();
}

class _FoodsListScreenState extends State<FoodsListScreen> {
  Future<List<Food>> futureFoods;
  List<String> ingredientsList = [];
  bool cardDisabled = false;
  String pageName = '';

  Future ingredients(context, id) async {
    var outcome =
        await IngredientsGetter(context: context, foodId: id).getData();
    if (outcome != null) {
      List ingredients = outcome['data']['ingredient'];
      ingredientsList.clear();
      for (int i = 0; i < ingredients.length; i++) {
        ingredientsList.add(ingredients[i]['name']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    futureFoods = fetchFoods(context, chosenMenuId);
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
            child: FutureBuilder<List<Food>>(
              future: futureFoods,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomCard(
                        id: snapshot.data[index].id,
                        title: snapshot.data[index].name,
                        img: snapshot.data[index].img,
                        isFood: true,
                        foodSubtitle: snapshot.data[index].description,
                        cardDisabled: cardDisabled,
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            cardDisabled = true;
                          });
                          chosenFoodId = snapshot.data[index].id;
                          await ingredients(context, snapshot.data[index].id);
                          Navigator.pushNamed(context, SingleFoodScreen.id,
                              arguments: {
                                "id": snapshot.data[index].id,
                                "title": snapshot.data[index].name,
                                "description": snapshot.data[index].description,
                                "price": '1000',
                                "img": snapshot.data[index].img,
                                "ingredientsList": ingredientsList,
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
                    "Список блюд пуст".toUpperCase(),
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
