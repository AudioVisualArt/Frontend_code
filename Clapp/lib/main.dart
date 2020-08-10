import 'package:flutter/material.dart';

import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/routes/routes.dart';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  runApp(MyApp());

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: getApplicationRoutes(),
      theme: ThemeData(primaryColor: Color.fromRGBO(0, 51, 51, 1.0)),
    ));
  }
}
