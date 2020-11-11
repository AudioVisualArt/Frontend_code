import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';

class HomePagePrincipal extends StatefulWidget {
  @override
  _HomePagePrincipal createState() => _HomePagePrincipal();
}

class _HomePagePrincipal extends State<HomePagePrincipal> {
  ChatProvider chatprovider = new ChatProvider();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.white,
          //shadowColor: Colors.grey,
          //title: Text('CLAPP',
          //  style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          ),
      drawer: MenuWidget(
        userModel: usuario,
      ),
      //Rest backend Springboot
      body: _crearBody(context, usuario),
    );
  }

  Widget _crearBody(BuildContext context, UserModel usuario) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/img/homeback2.jpg"),
        fit: BoxFit.cover,
      )),
      child: Container(
        height: MediaQuery.of(context).size.height - 30.0,
        width: size.width,
        margin: EdgeInsets.symmetric(vertical: 0.0),
        padding: EdgeInsets.symmetric(vertical: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 30, bottom: 12),
                  child: Text("Hola, " + usuario.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        color: Colors.black,
                      )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text("Menú Principal",
                      style: TextStyle(
                          fontSize: 31.0,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              //_mostrarFotoPerfil(),
              SizedBox(height: 30.0),
              _opcionMenu(
                  context,
                  usuario,
                  'Estudio',
                  'Empieza Creando un Proyecto',
                  Icons.local_convenience_store,
                  0),
              _opcionMenu(
                  context,
                  usuario,
                  'Mercado',
                  'Encuentra Guiones, Fotos, Equipos para tu proyecto',
                  Icons.store_mall_directory,
                  1),
              _opcionMenu(
                  context,
                  usuario,
                  'Servicios',
                  'Gestiona el personal y las locaciones de tu proyecto',
                  Icons.work,
                  2),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 30, bottom: 12),
                  child: Text('Pública tus servicios en Clapp',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        color: Colors.black,
                      )),
                ),
              ),
              _opcionMenu(
                  context,
                  usuario,
                  'Se parte de un proyecto',
                  'Pública tu perfil y conviertete en un Clapper',
                  Icons.person,
                  3),
              _opcionMenu(
                  context,
                  usuario,
                  'Pública una Locación',
                  'Alquila tu propiedad para filmar obras audiovisuales y gana dinero',
                  Icons.location_on_rounded,
                  4),
              _opcionMenu(
                  context,
                  usuario,
                  'Vender',
                  'Publica tus productos en el mercado',
                  Icons.shopping_cart_rounded,
                  6),
              //_carruselStudio(usuario),
              SizedBox(height: 25.0),
              //_carruselMarket(usuario),
              SizedBox(height: 25.0),
              //_carruselServicio(usuario),
            ],
          ),
        ),
      ),
    );
  }

  Widget _opcionMenu(BuildContext context, UserModel usuario, String titulo,
      String description, icon, onPressed) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: InkWell(
          onTap: () {
            switch (onPressed) {
              case 0:
                Navigator.pushNamed(context, 'proyectos', arguments: usuario);
                //Navigator.pushNamed(context, 'my_studio', arguments: usuario);

                break;
              case 1:
                Navigator.pushNamed(context, 'home_market', arguments: usuario);
                break;
              case 2:
                Navigator.pushNamed(context, 'home_servicios',
                    arguments: usuario);
                break;
              case 3:
                Navigator.pushNamed(context, 'new_service', arguments: usuario);
                break;
              case 4:
                Navigator.pushNamed(context, 'nuevoespacio',
                    arguments: usuario);
                break;
              case 5:
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MostrarProductosPage(
                              userModel: usuario,
                            )));
                break;
              case 6:
                Navigator.pushNamed(context, 'menu_mostrar',
                    arguments: usuario);
                break;

              case 11:
                print("Falta la ruta");
                break;
            }
          },
          child: Container(
            height: 105,
            width: MediaQuery.of(context).size.width - 40,
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    padding: EdgeInsets.only(top: 8, left: 11, right: 7),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(112, 252, 118, 1),
                          Color.fromRGBO(121, 181, 136, 1),
                        ]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 4),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, -6),
                            blurRadius: 25,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 3.0, left: 10),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 24, maxWidth: 270),
                                    child: Text(titulo,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: "Raleway",
                                            color: Color.fromRGBO(
                                                100, 100, 110, 1),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(

                                    constraints: BoxConstraints(
                                        maxHeight: 65, maxWidth: 235),
                                    child: Text(description,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Raleway",
                                          color: Colors.black87,
                                          //fontWeight: FontWeight.bold
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 6,
                              right: 10,
                            ),
                            child: Container(
                                height:
                                    73, //MediaQuery.of(context).size.height - 610,
                                width: 77, //
                                child: Hero(
                                    tag: icon,
                                    child: Icon(
                                      icon,
                                      color: Colors.black,
                                      size: 75,
                                    )) //                                       MediaQuery.of(context).size.width - 335,

                                ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  Widget _mostrarFotoPerfil() {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            image: DecorationImage(
              image: AssetImage('assets/img/APP ICON.png'),
              fit: BoxFit.cover,
            )),
        height: 150.0,
        width: 150.0,
      ),
    );
  }

  Widget _carruselStudio(UserModel usuario) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(),
              child: ClipPath(
                  clipper: ClippCarrusel(),
                  child: Container(
                      color: Color.fromRGBO(112, 252, 118, 0.8),
                      height: 115, //MediaQuery.of(context).size.height - 570,
                      width: 131, //MediaQuery.of(context).size.width - 280,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, 'my_studio',
                            arguments: usuario),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                right: 18,
                              ),
                              child: Container(
                                  height:
                                      73, //MediaQuery.of(context).size.height - 610,
                                  width:
                                      77, //                                      MediaQuery.of(context).size.width - 335,

                                  child: Icon(
                                    Icons.local_convenience_store,
                                    color: Colors.black,
                                    size: 75,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                right: 18,
                              ),
                              child: Text("Estudio",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontSize: 18,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      )))),
        )
      ],
    );
  }

  Widget _carruselMarket(UserModel usuario) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(),
              child: ClipPath(
                  clipper: ClippCarrusel(),
                  child: Container(
                      color: Color.fromRGBO(112, 252, 118, 0.8),
                      height: 115, //MediaQuery.of(context).size.height - 570,
                      width: 131, // MediaQuery.of(context).size.width - 280,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, 'home_market',
                            arguments: usuario),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                right: 18,
                              ),
                              child: Container(
                                  height:
                                      73, //MediaQuery.of(context).size.height - 610,
                                  width: 77, //
                                  child: Hero(
                                      tag: Icons.store_mall_directory,
                                      child: Icon(
                                        Icons.store_mall_directory,
                                        color: Colors.black,
                                        size: 75,
                                      )) //                                       MediaQuery.of(context).size.width - 335,

                                  ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                right: 18,
                              ),
                              child: Text("Mercado",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontSize: 18,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      )))),
        )
      ],
    );
  }

  Widget _carruselServicio(UserModel usuario) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(),
              child: ClipPath(
                  clipper: ClippCarrusel(),
                  child: Container(
                      color: Color.fromRGBO(112, 252, 118, 0.8),
                      height: 115, //MediaQuery.of(context).size.height - 570,
                      width: 131, // MediaQuery.of(context).size.width - 280,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, 'home_servicios',
                            arguments: usuario),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                right: 18,
                              ),
                              child: Container(
                                  height:
                                      73, //                                     MediaQuery.of(context).size.height - 610,
                                  width:
                                      77, //                                     MediaQuery.of(context).size.width - 335,
                                  child: Hero(
                                      tag: Icons.work,
                                      child: Icon(
                                        Icons.work,
                                        color: Colors.black,
                                        size: 75,
                                      ))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                right: 18,
                              ),
                              child: Text("Servicios",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontSize: 18,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      )))),
        )
      ],
    );
  }
}

class ClippCarrusel extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // TODO: implement getClip
    path.lineTo(size.width, 0.0);
    path.lineTo((size.width / 4) * 3, size.height);
    path.lineTo(0.0, size.height);
    //path.moveTo((size.width/3)*2,size.width);
    //path.lineTo(size.width, size.height);
    //path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
