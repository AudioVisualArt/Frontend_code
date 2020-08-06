import 'dart:io';

import 'package:Clapp/src/User/widgets/background_image.dart';
import 'package:flutter/material.dart';

class BackgroundTitle extends StatelessWidget{
  double height;
  double width;
  String pathImage;
  double left;
  String text;
  BackgroundTitle({
    @required this.height,
    @required this.width,
    @required this.pathImage,
    @required this.left,
    @required this.text
  });


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: <Widget>[
          BackgroundImage(pathImage: pathImage,left: left,width: width,height: height),
          SizedBox(height: 10.0, width: double.infinity),
          Text(text , style: TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: "RalewayBold" ))
        ],
      ),
    );;
  }



}