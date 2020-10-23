import 'dart:ui';

import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/NewHome/Pages/recomendados_market.dart';
import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/ScreenPlay/Provider/screenplay_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:flutter/material.dart';

import 'elemento_carrusel.dart';

class HomeMarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeMarketPage();
  }
}

class _HomeMarketPage extends State<HomeMarketPage> {
  final equiposProvider = new EquipmentProvider();
  final screenplayProvider = new ScreenPlayProvider();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          /* ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image(
                              image: AssetImage('assets/img/no-image.png'),
                              fit: BoxFit.cover,
                              width: 60.0,
                              height: 60.0,
                            ),
                          )

                          */
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 30, bottom: 12),
                    child: Text("Mercado",
                        style: TextStyle(
                            fontSize: 31.0,
                            fontFamily: "Raleway",
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: Text("Productos que te pueden interesar",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          //fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(
                    height: 310,
                    child: _ListadoEquipments(),
                  ),
                  SizedBox(
                    height: 100,
                    child: _ListarGuion(),
                  ),
                  SizedBox(height: 110.0),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 115,
              child: _carruselMarket(usuario),
            ),
          ],
        ));
  }

  Widget _ListadoEquipments() {
    return FutureBuilder(
      future: equiposProvider.cargarEquipments(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EquipmentModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: equipos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 1),
                  child: RecomendadosMarket(equipos: equipos[index]),
                  //_equiposCard(context, equipos[index]),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(0, 51, 51, 1.0),
            )),
          );
        }
      },
    );
  }

  Widget _ListarGuion() {
    return FutureBuilder(
      future: screenplayProvider.cargarScreenPlays(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ScreenPlayModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: equipos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _GuionBanner(context, equipos[index]),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(0, 51, 51, 1.0),
            )),
          );
        }
      },
    );
  }

  Widget _GuionBanner(BuildContext context, ScreenPlayModel guion) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        height: 75,
        width: 300,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding: EdgeInsets.only(top: 10, left: 10),
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
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Container(
                        height: 24,
                        width: 280,
                        child: Text(guion.titulo + ",",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(100, 100, 110, 1),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    /*Text("${guion.pages.toString()} paginas",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      )),

                  */
                    _autor(context, guion.idOwner),
                    Text("Generó: " + guion.topic,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Raleway",
                          color: Colors.black87,
                          //fontWeight: FontWeight.bold
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _autor(BuildContext context, String id) {
    final usuarioProvider = UsuarioProvider();

    return FutureBuilder(
        future: usuarioProvider.obtenerUsuario(id),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return Text(
              'Publicado por ' + snapshot.data.name,
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Raleway",
              ),
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        });
  }

  Widget _carruselMarket(UserModel usuario) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(),
            child: ClipRect(
              child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),

                    /*decoration: ConcaveDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  colors: [
                    Color.fromRGBO(230, 230, 230, 0.5),
                    Color.fromRGBO(247, 245, 245, 0.5),
                  ],
                  depression: 15),

               */
                    //color: Color.fromRGBO(227, 227, 227, 1),
                    height: 115, //MediaQuery.of(context).size.height - 570,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 125,
                        ),
                        ElementoMenu(
                          name: 'Buscar',
                          onPressed: 6,
                          usuario: usuario,
                          imagenIcono: "assets/img/searchIcon.png",
                          colorfondo: Color.fromRGBO(231, 74, 74, 1.0),
                        ),

                        ElementoMenu(
                          name: 'Equipo',
                          onPressed: 9,
                          usuario: usuario,
                          imagenIcono: "assets/img/equipoIcon.png",
                          colorfondo: Color.fromRGBO(253, 132, 105, 1.0),
                        ),
                        ElementoMenu(
                          name: 'Imagenes',
                          onPressed: 12,
                          usuario: usuario,
                          imagenIcono: "assets/img/imagesIcon.png",
                          colorfondo: Color.fromRGBO(255, 105, 76, 1.0),
                        ),
                        ElementoMenu(
                          name: 'Guiones',
                          onPressed: 10,
                          usuario: usuario,
                          imagenIcono: "assets/img/guionIcon.jpg",
                          colorfondo: Color.fromRGBO(253, 196, 18, 1.0),
                        ),
                        ElementoMenu(
                          name: 'Props',
                          onPressed: 7,
                          usuario: usuario,
                          imagenIcono: "assets/img/propsIcon.png",
                          colorfondo: Color.fromRGBO(190, 214, 48, 1.0),
                        ),
                        //elementoMenu('Accesorios', 6, usuario, "assets/img/imagesIcon.png", Color.fromRGBO(255, 105, 76, 1.0),),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  )),
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
                                  child: Hero(
                                      tag: Icons.store_mall_directory,
                                      child: Icon(
                                        Icons.store_mall_directory,
                                        color: Colors.black,
                                        size: 75,
                                      ))),
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
}
