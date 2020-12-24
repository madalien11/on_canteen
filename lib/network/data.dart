import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:on_canteen/classes/BuffetItemTypes.dart';
import 'package:on_canteen/classes/BuffetItems.dart';
import 'package:on_canteen/classes/Institution.dart';
import 'package:on_canteen/classes/dateClass.dart';
import 'package:on_canteen/classes/dietolog.dart';
import 'package:on_canteen/classes/food.dart';
import 'package:on_canteen/classes/ingredient.dart';
import 'package:on_canteen/classes/menu.dart';

String tokenString;
String refreshTokenString;
Function logOutInData = () => print('Log Out In Data');
Function addTokenInData = () => print('Add Token In Data');
String root = 'http://api.contra.kz/';

class Regions {
  Future getData() async {
    http.Response response = await http.get(root + "api/regions/");
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else {
      print('regions ' + response.statusCode.toString());
    }
  }
}

class CreateForm {
  String name;
  String phoneNumber;
  String question;
  CreateForm({
    this.name,
    this.phoneNumber,
    this.question,
  });
  Future create() async {
    http.Response response =
        await http.post(root + 'api/question/create/', body: {
      "name": name,
      "phone_number": phoneNumber,
      "question": question,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Registration {
  String email;
  String phoneNum;
  String firstName;
  String lastName;
  String password1;
  String password2;
  Registration(
      {@required this.email,
      @required this.phoneNum,
      @required this.firstName,
      @required this.lastName,
      @required this.password1,
      @required this.password2});
  Future register() async {
    http.Response response =
        await http.post(root + "user/registration/", body: {
      'email': email,
      'phone': phoneNum,
      'first_name': firstName,
      'last_name': lastName,
      'password1': password1,
      'password2': password2,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Login {
  String phoneNum;
  String password;
  Login({this.phoneNum, @required this.password});
  Future login() async {
    String newNum = "";
    for (int i = phoneNum.length - 10; i < phoneNum.length; i++) {
      newNum += phoneNum[i];
    }
    http.Response response = await http.post(root + "user/token/", body: {
      'phone': newNum,
      'password': password,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Refresh {
  Future refresh() async {
    http.Response response = await http.post(
        "http://papi.trapezza.kz/user/token/refresh/",
        body: {'refresh': refreshTokenString});
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      tokenString = jsonDecode(source)['access'];
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class EmailValidate {
  String email;
  EmailValidate({@required this.email});
  Future validate() async {
    http.Response response = await http
        .post("http://papi.trapezza.kz/user/validate_user_email/", body: {
      'email': email,
      'save': 'True',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class ForgotPasswordData {
  String email;
  String newPass;
  String confPass;
  ForgotPasswordData(
      {@required this.email, @required this.newPass, @required this.confPass});
  Future validate() async {
    http.Response response =
        await http.post("http://papi.trapezza.kz/user/forgot_password/", body: {
      'email': email,
      'password1': newPass,
      'password2': confPass,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class EmailConfirm {
  String email;
  String code;
  EmailConfirm({@required this.email, @required this.code});
  Future confirm() async {
    http.Response response = await http
        .put("http://papi.trapezza.kz/user/validate_user_email/", body: {
      'email': email,
      'otp': code,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class ChangePassword {
  final String password;
  final String password1;
  final String password2;
  BuildContext context;
  ChangePassword({this.password, this.password1, this.password2, this.context});
  Future putData() async {
    http.Response response =
        await http.put("http://papi.trapezza.kz/user/profile/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'password': password,
      'password1': password1,
      'password2': password2,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response =
          await http.put("http://papi.trapezza.kz/user/profile/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'password': password,
        'password1': password1,
        'password2': password2,
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        return jsonDecode(source);
      }
      print(response.statusCode);
    } else {
      print(response.statusCode);
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    }
  }
}

class ChangeProfile {
  final String username;
  final String password;
  BuildContext context;
  ChangeProfile({this.username, this.password, this.context});
  Future putData() async {
    http.Response response =
        await http.put("http://papi.trapezza.kz/user/profile/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response =
          await http.put("http://papi.trapezza.kz/user/profile/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        return jsonDecode(source);
      }
      print(response.statusCode);
    } else {
      print(response.statusCode);
      String source = Utf8Decoder().convert(response.bodyBytes);
      return jsonDecode(source);
    }
  }
}

Future<List<Institution>> fetchInstitutionTypes(BuildContext context) async {
  final response = await http.get(root + 'api/organizationtypes/');

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List institutionsList = jsonData['data'];
    List<Institution> institutions = [];
    for (var institution in institutionsList) {
      Institution s = Institution(
        id: institution['id'],
        name: institution['name'],
      );
      institutions.add(s);
    }
    return institutions;
  } else {
    throw Exception('institutionTypes ' + response.statusCode.toString());
  }
}

Future<List<Institution>> fetchInstitutions(
    BuildContext context, int id) async {
  if (id == null) id = 2;
  final response = await http.get(root + 'api/organizations/' + id.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List institutionsList = jsonData['data'];
    List<Institution> institutions = [];
    for (var institution in institutionsList) {
      Institution s = Institution(
        id: institution['id'],
        name: institution['name'],
        type: institution['type'],
        regiona: institution['regiona'],
      );
      institutions.add(s);
    }
    return institutions;
  } else {
    throw Exception('institutions ' + response.statusCode.toString());
  }
}

Future<List<BuffetItemTypes>> fetchBuffetItemTypes(
    BuildContext context, int id) async {
  if (id == null) id = 2;
  final response = await http.get(root + 'api/getcatalog/' + id.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List buffetItemTypesList = jsonData['data'];
    List<BuffetItemTypes> buffetItemTypes = [];
    for (var buffetItemType in buffetItemTypesList) {
      BuffetItemTypes s = BuffetItemTypes(
        id: buffetItemType['id'],
        name: buffetItemType['name'],
      );
      buffetItemTypes.add(s);
    }
    return buffetItemTypes;
  } else {
    throw Exception('buffetItemTypes ' + response.statusCode.toString());
  }
}

Future<List<BuffetItems>> fetchBuffetItems(
    BuildContext context, int institutionId, int buffetItemTypeId) async {
  if (institutionId == null) institutionId = 2;
  if (buffetItemTypeId == null) buffetItemTypeId = 2;
  final response = await http.get(root +
      'api/getproduct/' +
      institutionId.toString() +
      '/' +
      buffetItemTypeId.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List buffetItemsList = jsonData['data'];
    List<BuffetItems> buffetItems = [];
    for (var buffetItem in buffetItemsList) {
      BuffetItems s = BuffetItems(
        id: buffetItem['id'],
        name: buffetItem['name'],
        description: buffetItem['description'],
        img: buffetItem['img'],
        categoryId: buffetItem['category']['id'],
        categoryName: buffetItem['category']['name'],
      );
      buffetItems.add(s);
    }
    return buffetItems;
  } else {
    throw Exception('buffetItems ' + response.statusCode.toString());
  }
}

Future<List<Dietolog>> fetchDietolog(BuildContext context) async {
  final response = await http.get(root + 'api/dietolog/');

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List dietologList = jsonData['data'];
    List<Dietolog> dietologs = [];
    for (var dietolog in dietologList) {
      Dietolog s = Dietolog(
        id: dietolog['id'],
        name: dietolog['name'],
        surname: dietolog['surname'],
        description: dietolog['description'],
        img: dietolog['img'],
      );
      dietologs.add(s);
    }
    return dietologs;
  } else {
    throw Exception('dietolog ' + response.statusCode.toString());
  }
}

Future<List<DateClass>> fetchDates(
    BuildContext context, int institutionId) async {
  final response = await http
      .get(root + 'api/datesByOrganization/' + institutionId.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List datesList = jsonData['data'];
    List<DateClass> dates = [];
    for (var date in datesList) {
      DateClass s = DateClass(
        id: date['id'],
        name: date['name'],
        week: date['week'],
        date: date['date'],
        today: date['today'],
      );
      dates.add(s);
    }
    return dates;
  } else {
    throw Exception('Dates ' + response.statusCode.toString());
  }
}

Future<List<Menu>> fetchMenus(
    BuildContext context, int institutionId, int dayId) async {
  final response = await http.get(root +
      'api/getmenu/' +
      institutionId.toString() +
      '/' +
      dayId.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List menusList = jsonData['data'];
    List<Menu> menus = [];
    for (var menu in menusList) {
      Menu s = Menu(
        id: menu['id'],
        name: menu['name'],
        description: menu['description'],
        img: menu['img'],
        categoryId: menu['category']['id'],
        categoryName: menu['category']['name'],
      );
      menus.add(s);
    }
    return menus;
  } else {
    throw Exception('Menus ' + response.statusCode.toString());
  }
}

Future<List<Food>> fetchFoods(BuildContext context, int menuId) async {
  final response = await http.get(root + 'api/getfoods/' + menuId.toString());

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List foodsList = jsonData['data'];
    List<Food> foods = [];
    for (var food in foodsList) {
      Food s = Food(
        id: food['id'],
        name: food['name'],
        description: food['description'],
        img: food['img'],
        price: food['price'],
        certificate: food['certificate'],
        categoryId: food['category']['id'],
        categoryName: food['category']['name'],
      );
      foods.add(s);
    }
    return foods;
  } else {
    throw Exception('Foods ' + response.statusCode.toString());
  }
}

Future<List<Ingredient>> fetchIngredients(
    BuildContext context, int foodId) async {
  final response =
      await http.get(root + 'api/getIngredient/' + foodId.toString());
  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    String source = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(source);
    List ingredientsList = jsonData['data'];
    List<Ingredient> ingredients = [];
    for (var ingredient in ingredientsList) {
      Ingredient s = Ingredient(
        id: ingredient['id'],
        name: ingredient['name'],
      );
      ingredients.add(s);
    }
    return ingredients;
  } else {
    throw Exception('Ingredients ' + response.statusCode.toString());
  }
}
