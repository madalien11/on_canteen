import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

String tokenString;
String refreshTokenString;
Function logOutInData = () => print('Log Out In Data');
Function addTokenInData = () => print('Add Token In Data');
String root = 'http://papi.trapezza.kz/api/';

class Login {
  String phoneNum;
  String password;
  Login({this.phoneNum, @required this.password});
  Future login() async {
    http.Response response =
        await http.post("http://papi.trapezza.kz/user/login/", body: {
      'phone': phoneNum,
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

class Registration {
  String email;
  String phoneNum;
  String username;
  String password1;
  String password2;
  Registration(
      {@required this.email,
      @required this.phoneNum,
      @required this.username,
      @required this.password1,
      @required this.password2});
  Future register() async {
    http.Response response =
        await http.post("http://papi.trapezza.kz/user/registration/", body: {
      'email': email,
      'phone': phoneNum,
      'username': username,
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
