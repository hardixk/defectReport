//ignore_for_file: use_key_in_widget_constructors

import 'package:calculator/fifthPage.dart';
import 'package:flutter/material.dart';
import 'package:calculator/firstPage.dart';
import 'package:calculator/secPage.dart';
import 'package:calculator/ThirdPage.dart';
import 'package:calculator/fourthPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Defect Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => const SecondPage(),
        '/third': (context) => const ThirdPage(),
        '/fourth': (context) => FourthPage(),
        '/fifth': (context) => const FifthPage(),
      },
    );
  }
}
