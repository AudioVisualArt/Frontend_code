import 'package:flutter/material.dart';

class SpaceDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SpaceDetails();
  }

}
 class _SpaceDetails extends State<SpaceDetails>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text('Detalles',
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
     ),
     //body:
   );
  }

 }