import 'dart:io';

import 'package:flutter/material.dart';

class BackgroundImage extends  StatelessWidget{
  double height;
  double width;
  String pathImage;
  double left;

  BackgroundImage({
    @required this.height,
    @required this.width,
    @required this.pathImage,
    @required this.left
});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
          left: left

      ),

      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              //image: AssetImage(pathImage)
              image: pathImage.contains('assets')? AssetImage(pathImage):new FileImage(new File(pathImage))
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow (
                color:  Colors.white,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0)
            )
          ]

      ),
    );
}


}