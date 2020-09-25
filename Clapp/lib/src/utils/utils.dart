import 'package:flutter/material.dart';

/**
*La variable [url] sera utilizada para los provider (serivicios)
*que lleguen desde el back, cuando cada uno tenga el front en su CPU,
*esto sera solo hasta el despliegue o mientras se esta desarrollando mas
*NO en Producción
*/

//final url = 'http://192.168.0.12:8080'; //Lemus
//final url = 'http://192.168.0.18:8080'; //Sebastian

//final url = 'http://192.168.0.3:8080'; //jonathan
final url = 'http://192.168.0.16:8080'; //Camilo

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titleTextStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
        title: Text('Información Incorrecta',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: "RalewayBold")),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
