import 'package:flutter/material.dart';
import 'package:wpandflutterconnect/pages/home_page.dart';
import 'package:wpandflutterconnect/pages/login_page.dart';
import 'package:wpandflutterconnect/services/shared_service.dart';

Widget _defaultHome = new LoginPage();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future<bool?> _result = SharedService.isLoggedIn();
  if(_result == true){
    _defaultHome = new HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordpress Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        accentColor: Colors.cyan[600]
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(),
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}