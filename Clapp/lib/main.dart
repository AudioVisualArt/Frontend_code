import 'package:flutter/material.dart';

import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: getApplicationRoutes(),
      theme: ThemeData(primaryColor: Color.fromRGBO(0, 51, 51, 1.0)),
    ));
  }
}
