import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

String tokenString;
String refreshTokenString;
Function logOutInData = () => print('Log Out In Data');
Function addTokenInData = () => print('Add Token In Data');
String root = 'http://papi.trapezza.kz/api/';
