import 'package:flutter/material.dart';

import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/login_page.dart';
import 'package:Clapp/src/User/pages/signup_page.dart';
import 'package:Clapp/src/item/pages/producto_page.dart';
import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:Clapp/src/MyStudio/pages/my_studio_page.dart';
import 'package:Clapp/src/MyStudio/pages/store_page.dart';
import 'package:Clapp/src/projectos/pages/new_project_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'signUp': (BuildContext context) => SignUp(),
    'producto': (BuildContext context) => ProductoPage(),
    'ver_producto': (BuildContext context) => MostrarProductosPage(),
    'my_studio': (BuildContext context) => MyStudioPage(),
    'store': (BuildContext context) => StorePage(),
    'new_project': (BuildContext context) => NewProjectPage(),
  };
}
