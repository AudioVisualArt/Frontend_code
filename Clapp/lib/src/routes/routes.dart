import 'package:flutter/material.dart';

import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/pages/login_page.dart';
import 'package:Clapp/src/User/pages/signup_page.dart';
import 'package:Clapp/src/item/pages/producto_page.dart';
import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:Clapp/src/MyStudio/pages/my_studio_page.dart';
import 'package:Clapp/src/MyStudio/pages/store_page.dart';
import 'package:Clapp/src/projectos/pages/new_project_page.dart';
import 'package:Clapp/src/Contract/pages/new_contract.dart';
import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/User/pages/settings_page.dart';
import 'package:Clapp/src/User/pages/favourites_page.dart';
import 'package:Clapp/src/User/pages/profile_page.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/services/pages/services_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'signUp': (BuildContext context) => SignUp(),
    'producto': (BuildContext context) => ProductoPage(),
    'ver_producto': (BuildContext context) => MostrarProductosPage(),
    'my_studio': (BuildContext context) => MyStudioPage(),
    'store': (BuildContext context) => StorePage(),
    'services': (BuildContext context) => ServicesPages(),
    'new_project': (BuildContext context) => NewProjectPage(),
    'settings': (BuildContext context) => SettingsPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'favourite': (BuildContext context) => FavouritePage(),
    'message': (BuildContext context) => MessagePage(),
    'see_contracts': (BuildContext context) => VerContratos(),
    'new_contract': (BuildContext context) => NewContract(),
  };
}
