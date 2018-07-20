import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_jiandan/pages/main_page.dart';
import 'package:flutter_jiandan/redux/store.dart';
import 'package:flutter_jiandan/redux/app/app_state.dart';

void main() {
  // ignore: deprecated_member_use
  MaterialPageRoute.debugEnableFadingRoutes = true;

  var store = createStore();
  runApp(MyApp(store));
}

class MyApp extends StatefulWidget {
  MyApp(this.store);
  final Store<AppState> store;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    // widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: '煎蛋',
        theme: ThemeData(
  //        primaryColor: Colors.white,
          primaryColor: Color(0xFF63CA6C),
        ),
        home: MainPage(),
      ),
    );
  }
}

