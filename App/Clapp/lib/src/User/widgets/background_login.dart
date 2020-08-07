import 'package:Clapp/src/User/widgets/background_appbar.dart';
import 'package:Clapp/src/User/widgets/backgrund_title.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget{
  String text;
  Background({
    @required this.text
  });
  @override
  Widget build(BuildContext context) {

      return Stack(
        children: <Widget>[
          BackgroundAppbar(),
          BackgroundTitle(height: 80,width: 200,left: 0,text: text, pathImage: "assets/img/CORPORATELOGO_whitebackgrounds-HEXA.png")
        ],
      );

    }
  }

