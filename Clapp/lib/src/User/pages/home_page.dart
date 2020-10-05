import 'package:Clapp/src/Space/pages/spaces_page.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Widget elementoMenu(String name, int onPressed, UserModel usuario,
      String imagenIcono, _colorfondo) {
    return Padding(
        padding: EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: () {
            switch (onPressed) {
              case 0:
                Navigator.pushNamed(context, 'proyectos', arguments: usuario);

                break;
              case 1:
                Navigator.pushNamed(context, 'ver_producto',
                    arguments: usuario);
                break;
              case 2:
                Navigator.pushNamed(context, 'open_contracts',
                    arguments: usuario);
                break;
              case 3:
                Navigator.pushNamed(context, 'contratos', arguments: usuario);
                break;
              case 4:
                Navigator.pushNamed(context, 'open_contracts',
                    arguments: usuario);
                break;
              case 5:
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SpacesPage()));
                break;
              case 6:
                print('Sin ruta');
                //Navigator.pushNamed(context, 'find_photo', arguments: usuario);
                break;
              case 7:
                Navigator.pushNamed(context, 'items_buy', arguments: usuario);
                break;
              case 8:
                Navigator.pushNamed(context, 'mycontract',arguments: usuario);
                break;
            }
            ;
          },
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 115, //MediaQuery.of(context).size.height - 570,
              maxWidth: 115, //MediaQuery.of(context).size.width - 250,
              minWidth: 101, //MediaQuery.of(context).size.width - 310
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image(
                        image: AssetImage(imagenIcono),
                        fit: BoxFit.cover,
                      ),
                    ),

                    height: 68, //MediaQuery.of(context).size.height - 615,
                    width: 68, // MediaQuery.of(context).size.width - 340,
                    decoration: BoxDecoration(
                      color: _colorfondo,
                      borderRadius: BorderRadius.circular(12.0),
                      /* border: Border.all(
                        width: 1.3,
                        color: Color.fromRGBO(0, 51, 51, 0.8),
                      ),
                      */
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(name,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 51, 51, 0.9),
                          fontSize: 18,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold)),
                )
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
        Padding(
            padding: EdgeInsets.only(),
            child: Container(
              decoration: ConcaveDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  colors: [
                    Color.fromRGBO(230, 230, 230, 0.5),
                    Color.fromRGBO(247, 245, 245, 0.5),
                  ],
                  depression: 15),
              //color: Color.fromRGBO(227, 227, 227, 1),
              height: 115, //MediaQuery.of(context).size.height - 570,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 125,
                  ),
                  elementoMenu(
                    'Proyectos',
                    0,
                    usuario,
                    "assets/img/proyectosIcon2.jpg",
                    Color.fromRGBO(236, 149, 156, 1.0),
                  ),
                  elementoMenu(
                    'Tienda',
                    1,
                    usuario,
                    "assets/img/tiendaIcon2.jpg",
                    Color.fromRGBO(255, 199, 86, 1),
                  ),
                  elementoMenu(
                    'Contratos',
                    8,
                    usuario,
                    "assets/img/iconodecontratos.png",
                    Color.fromRGBO(255, 105, 76, 1.0),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            )),
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
        Padding(
            padding: EdgeInsets.only(),
            child: Container(
              decoration: ConcaveDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  colors: [
                    Color.fromRGBO(230, 230, 230, 0.5),
                    Color.fromRGBO(247, 245, 245, 0.5),
                  ],
                  depression: 15),
              //color: Color.fromRGBO(227, 227, 227, 1),
              height: 115, //MediaQuery.of(context).size.height - 570,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 125,
                  ),
                  elementoMenu(
                    'Imagenes',
                    6,
                    usuario,
                    "assets/img/imagesIcon.png",
                    Color.fromRGBO(255, 105, 76, 1.0),
                  ),
                  elementoMenu(
                    'Equipo',
                    7,
                    usuario,
                    "assets/img/equipoIcon.png",
                    Color.fromRGBO(253, 132, 105, 1.0),
                  ),
                  elementoMenu(
                    'Guiones',
                    7,
                    usuario,
                    "assets/img/guionIcon.jpg",
                    Color.fromRGBO(253, 196, 18, 1.0),
                  ),
                  elementoMenu(
                    'Props',
                    7,
                    usuario,
                    "assets/img/propsIcon.png",
                    Color.fromRGBO(190, 214, 48, 1.0),
                  ),
                  //elementoMenu('Accesorios', 6, usuario, "assets/img/imagesIcon.png", Color.fromRGBO(255, 105, 76, 1.0),),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            )),
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
                        onTap: () => Navigator.pushNamed(context, 'items_buy',
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
                                      77, //                                         MediaQuery.of(context).size.width - 335,

                                  child: Icon(
                                    Icons.store_mall_directory,
                                    color: Colors.black,
                                    size: 75,
                                  )),
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
        Padding(
            padding: EdgeInsets.only(),
            child: Container(
              decoration: ConcaveDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  colors: [
                    Color.fromRGBO(230, 230, 230, 0.5),
                    Color.fromRGBO(247, 245, 245, 0.5),
                  ],
                  depression: 15),
              //color: Color.fromRGBO(227, 227, 227, 1),
              height: 115, //MediaQuery.of(context).size.height - 570,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 125,
                  ),
                  elementoMenu(
                    'Personal',
                    3,
                    usuario,
                    "assets/img/personalIcon.png",
                    Color.fromRGBO(27, 155, 170, 1.0),
                  ),
                  elementoMenu(
                    'Espacios',
                    5,
                    usuario,
                    "assets/img/locationIcon.png",
                    Color.fromRGBO(204, 190, 176, 1.0),
                  ),
                  elementoMenu(
                    'Contratos',
                    4,
                    usuario,
                    "assets/img/contractIcon.png",
                    Color.fromRGBO(255, 211, 78, 1.0),
                  ),

                  //elementoMenu(usuario,'Catering'),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            )),
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
                        onTap: () => Navigator.pushNamed(context, 'services',
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

                                  child: Icon(
                                    Icons.work,
                                    color: Colors.black,
                                    size: 75,
                                  )),
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
