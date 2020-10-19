import 'package:Clapp/src/Market/pages/show_equipments_page.dart';
import 'package:Clapp/src/Market/pages/show_screenplays_page.dart';
import 'package:Clapp/src/Space/pages/spaces_page.dart';
import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:flutter/material.dart';
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
        title: Text('CLAPP',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
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
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _mostrarFotoPerfil(),
              SizedBox(height: 20.0),
              _carruselStudio(usuario),
              SizedBox(height: 25.0),
              _carruselMarket(usuario),
              SizedBox(height: 25.0),
              _carruselServicio(usuario),
            ],
          ),
        ),
      ),
    );
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
                                  width:
                                  77, //
                                  child: Hero(
                                    tag: Icons.store_mall_directory,
                                      child: Icon(
                                        Icons.store_mall_directory,
                                        color: Colors.black,
                                        size: 75,
                                      )
                                  )//                                       MediaQuery.of(context).size.width - 335,

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
                        onTap: () => Navigator.pushNamed(context, 'home_servicios',
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
                                    tag:  Icons.work,
                                      child: Icon(
                                        Icons.work,
                                        color: Colors.black,
                                        size: 75,
                                      )
                                  )

                                  ),
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