import 'package:Clapp/src/services/Widgets/el_appbar.dart';
import 'package:flutter/material.dart';

class NewHeader extends StatelessWidget {
@override
Widget build(BuildContext context) {
  // TODO: implement build
  /*return Container(
      color: Colors.indigo,
    );*/
  return Stack(
    children: <Widget>[
      //ProfileBackground(),
      ListView(
        children: <Widget>[
          ElAppbar("Proyectos", 200.0),
          //ProfilePlacesList()

        ],
      ),
    ],
  );
}

}