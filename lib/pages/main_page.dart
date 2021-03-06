import 'package:flutter/material.dart';
import 'package:flutter_jiandan/pages/meizi/meizi_page.dart';
import 'package:flutter_jiandan/widgets/drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('妹子', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: MeiziPage(),
      drawer: MyDrawer(),
    );
  }
}