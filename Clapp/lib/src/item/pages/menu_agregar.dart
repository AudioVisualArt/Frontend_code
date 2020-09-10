import 'dart:ui';

import 'package:flutter/material.dart';

class MenuAgregarPage extends StatelessWidget {
  const MenuAgregarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¿Que Vas a Agregar?',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: SingleChildScrollView(
        child: _agregarBotones(context),
      ),
    );
  }

  Widget _agregarBotones(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBoton(
              context: context,
              image: Image(
                image: AssetImage(
                    'assets/img/visual-production_vintage-film-camera-512.png'),
                height: 700.0,
                width: 200.0,
              ),
              texto: 'Equipo',
              ruta: 'equipment'),
          _crearBoton(
              context: context,
              image: Image(
                image: AssetImage(
                    'assets/img/headphone-clipart-student-centers-9.png'),
                height: 800.0,
                fit: BoxFit.cover,
              ),
              texto: 'Guiones',
              ruta: 'guiones'),
        ]),
      ],
    );
  }

  Widget _crearBoton(
      {@required BuildContext context,
      @required Image image,
      @required String texto,
      @required String ruta}) {
    final boton = ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(89, 122, 121, 0.5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Color.fromRGBO(112, 252, 118, 0.6),
                  child: image),
              SizedBox(
                height: 10.0,
              ),
              Text(texto,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );

    return GestureDetector(
      child: boton,
      onTap: () => Navigator.pushNamed(context, ruta),
    );
  }
}
