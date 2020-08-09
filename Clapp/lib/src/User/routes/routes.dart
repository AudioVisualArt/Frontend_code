import 'package:flutter/material.dart';

import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/login_page.dart';
import 'package:Clapp/src/User/pages/signup_page.dart';
import 'package:Clapp/src/User/pages/producto_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'signUp': (BuildContext context) => SignUp(),
    'producto': (BuildContext context) => ProductoPage(),
  };
}
