import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:Clapp/src/item/pages/ver_props_page.dart';
import 'package:Clapp/src/item/pages/ver_screenplay_page.dart';
import 'package:Clapp/src/item/pages/ver_stock_page.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/User/models/user_model.dart';

class MenuMostrarPage extends StatelessWidget {
  const MenuMostrarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('¿ Cual de Tus Productos Quieres Ver ?',
            style: TextStyle(fontSize: 16.0, fontFamily: "Raleway")),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img/mostrarItems2.jpeg"),
              fit: BoxFit.cover,
            )),
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: _agregarBotones(context, usuario),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 51, 51, 1),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'menu_item', arguments: usuario);
        },
      ),
    );
  }

  Widget _agregarBotones(BuildContext context, UserModel userModel) {
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
              ruta: 0,
              userModel: userModel),
          _crearBoton(
              context: context,
              image: Image(
                image: AssetImage('assets/img/Performing-Arts-512.png'),
                height: 800.0,
                fit: BoxFit.fill,
              ),
              texto: 'Guiones',
              ruta: 1,
              userModel: userModel),
        ]),
        TableRow(children: [
          _crearBoton(
              context: context,
              image: Image(
                image: AssetImage('assets/img/modelinggicon.png'),
                fit: BoxFit.fitWidth,
              ),
              texto: 'Fotos',
              ruta: 2,
              userModel: userModel),
          _crearBoton(
              context: context,
              image: Image(
                image: AssetImage(
                    'assets/img/headphone-clipart-student-centers-9.png'),
                height: 800.0,
                fit: BoxFit.cover,
              ),
              texto: 'Props',
              ruta: 3,
              userModel: userModel),
        ]),
      ],
    );
  }

  Widget _crearBoton(
      {@required BuildContext context,
      @required Image image,
      @required String texto,
      @required int ruta,
      @required UserModel userModel}) {
    final boton = Card(
      elevation: 20.0,
      color: Color.fromRGBO(0, 51, 51, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: ClipRRect(
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(89, 122, 121, 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Color.fromRGBO(112, 252, 118, 0.6),
                child: image,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(texto,
                  style: TextStyle(
                      color: Colors.white,
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
        onTap: () {
          switch (ruta) {
            case 0:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MostrarProductosPage(
                            userModel: userModel,
                          )));

              break;
            case 1:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MostrarScreenPlayPage(
                            userModel: userModel,
                          )));
              break;
            case 2:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MostrarPhotosPage(
                            userModel: userModel,
                          )));
              break;
            case 3:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MostrarPropPage(
                            userModel: userModel,
                          )));
              break;
          }
          // Navigator.pushNamed(context, ruta, arguments: userModel);
        });
  }
}
