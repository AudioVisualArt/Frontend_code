import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/login_page.dart';
import 'package:Clapp/src/User/pages/signup_page.dart';
import 'package:flutter/material.dart';


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
          'signUp': (BuildContext context) => SignUp()
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 51, 51, 1.0)
        ),
      )
    );
  }
}