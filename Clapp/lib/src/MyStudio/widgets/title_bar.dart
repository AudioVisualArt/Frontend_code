import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  String titleName;
  TitleBar(this.titleName);
  @override
  Widget build(BuildContext context) {
    return actores();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Color.fromRGBO(209, 209, 209, 1),
            Color.fromRGBO(227, 227, 227, 1),
          ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
          stops: [0.0, 0.6],
          tileMode: TileMode.clamp),

      //border: Border.all(color: Color.fromRGBO(89, 122, 121, 1.0), width: 1.7),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );
  }

  Widget actores() {
    return Container(
      margin: const EdgeInsets.all(0.5),
      padding: const EdgeInsets.all(3.0),
      alignment: Alignment(1, 1),
      decoration: myBoxDecoration(), //
      child: Center(
        child: Text(
          titleName,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(89, 122, 121, 1.0)),
        ),
      ),
    );
  }
}
