import 'package:flutter/material.dart';

import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/login_page.dart';
import 'package:Clapp/src/User/pages/signup_page.dart';
import 'file:///E:/Tesis_Code/Clapp/lib/src/item/pages/producto_page.dart';
import 'file:///E:/Tesis_Code/Clapp/lib/src/item/pages/ver_productos_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'signUp': (BuildContext context) => SignUp(),
    'producto': (BuildContext context) => ProductoPage(),
    'ver_producto': (BuildContext context) => MostrarProductosPage(),
  };
}
