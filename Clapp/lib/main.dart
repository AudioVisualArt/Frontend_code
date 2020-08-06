import 'package:Clapp/src/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/pages/login_page.dart';
import 'package:Clapp/src/pages/home_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home'  : (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 51, 51, 1.0)
        ),
      )
    );
  }
}