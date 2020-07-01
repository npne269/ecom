import 'package:flutter/material.dart';
import 'package:shopping/pages/cart.dart';
import 'package:shopping/pages/homePage.dart';
import 'package:shopping/pages/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffa40000),
      ),
      home: LoginPage(),
      routes: {
        '/login':(_)=>LoginPage(),
        '/home': (_) => HomePage(),
        'cart':(_)=> CartPage(),
      },
    );
  }
}

