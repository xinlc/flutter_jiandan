import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '煎蛋',
      theme: ThemeData(
//        primaryColor: Colors.white,
        primaryColor: Color(0xFF63CA6C),
      ),
      home: MainPage(),
    );

  }
}

