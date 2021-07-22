import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_json/home.dart';

void main() async {
  List listOf = await getAllData();
  runApp(MyApp(listOf));
}

class MyApp extends StatelessWidget {
  List listOf;
  MyApp(this.listOf);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(listOf),
    );
  }
}

Future<List> getAllData() async {
  var api = "https://jsonplaceholder.typicode.com/posts";
  var data = await http.get(Uri.parse(api));
  var jsonData = json.decode(data.body);
  print(jsonData);
  return jsonData;
}