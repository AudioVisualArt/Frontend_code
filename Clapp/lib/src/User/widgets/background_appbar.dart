import 'package:flutter/material.dart';

class BackgroundAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    final fondoSuperior = Container(

      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(0, 51, 51, 1.0),
                Color.fromRGBO(89, 122, 121, 1.0)
              ]
          )
      ),

    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
    return Stack(
        children: <Widget>[
          fondoSuperior,
          Positioned(top: 90.0, left: 30.0, child: circulo),
          Positioned(bottom: -10.0, right: 10.0, child: circulo),
          Positioned(top: 10.0, right: 10.0, child: circulo),
        ]);
  }


}