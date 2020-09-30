import 'package:flutter/material.dart';

import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/routes/routes.dart';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

         /* builder: (context, widget) => ResponsiveWrapper.builder(

              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: '4K'),

              ],
              //background: Container(color: Color(0xFFF5F5F5))
          ),

          */




      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: getApplicationRoutes(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
              //centerTitle: true,
              iconTheme: IconThemeData(
                  color: Color.fromRGBO(115, 115, 115, 1.0)
              ),
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontSize: 25.0, fontFamily: "Raleway",
                      color: Color.fromRGBO(115, 115, 115, 1.0)
                  )


              )

          ),

          primaryColor: Color.fromRGBO(0, 51, 51, 1.0),),

    ));
  }
}

