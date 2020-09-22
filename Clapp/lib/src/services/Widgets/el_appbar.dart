import 'package:flutter/material.dart';

class ElAppbar extends StatelessWidget {


String title = "Finanzas";
double height = 0.0;

ElAppbar(this.title, this.height);

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return Container(
    height: height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              //Color(0xFF4268D3),
              //Color(0xFF584CD1)
            ],
            begin: FractionalOffset(0.2, 0.0),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp
        )
    ),


    child: Text(
      title,
      style: TextStyle(
          fontSize: 35.0,
          fontFamily: "Raleway",
          color: Color.fromRGBO(0, 51, 51, 1),
          fontWeight: FontWeight.bold
      ),
    ),

    alignment: Alignment(-0.9, -0.6),

  );
}

}