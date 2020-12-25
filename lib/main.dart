import 'package:flutter/material.dart';
import 'windows/home.dart';
import 'windows/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BmsGeo',
      theme: ThemeData(),
      home: Home(),
    );
  }
}