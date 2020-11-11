import 'dart:ui';

import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/NewHome/Pages/recomendados_market.dart';
import 'package:Clapp/src/NewHome/Pages/recomendados_workers.dart';
import 'package:Clapp/src/NewHome/Pages/top_locaciones.dart';
import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/ScreenPlay/Provider/screenplay_provider.dart';
import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/home_page.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:flutter/material.dart';

import 'elemento_carrusel.dart';

class HomeServiciosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeServiciosPage();
  }
}

class _HomeServiciosPage extends State<HomeServiciosPage> {
  final workerProvider = new WorkersProvider();
  final spacesProvider = new SpacesProvider();

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context, false),
          ),

        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Padding(
                      padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          /*ClipRRect(
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

                   */
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 26.0, left: 30, bottom: 12),
                    child: Text("Servicios",
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
                    child: Text("Top 10 Clappers",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          //fontWeight: FontWeight.bold
                        )),
                  ),
                  _ListadoWorkers(usuario),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: Text("Locaciones con mejores puntuaciones",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          //fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(
                    height: 310,
                    child: _ListarSpace(usuario),
                  ),
                  SizedBox(height: 110.0),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 195,
              child: _carruselServicio(usuario),
            ),
          ],
        ));
  }

  Widget _ListadoWorkers(UserModel usuario) {
    return FutureBuilder(
      future: workerProvider.cargarTrabajadores(),
      builder:
          (BuildContext context, AsyncSnapshot<List<WorkerModel>> snapshot) {
        if (snapshot.hasData) {
          final workers = snapshot.data;
          return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              //scrollDirection: Axis.vertical,
              itemCount: workers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 11.0, right: 11, top: 1),
                  child: RecomendadosWorkers(
                    workers: workers[index],
                    usuario: usuario,
                  ),
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

  Widget _ListarSpace(UserModel usuario) {
    return FutureBuilder(
      future: spacesProvider.cargarEspacios(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SpaceModel>> snapshot) {
        if (snapshot.hasData) {
          final espacios = snapshot.data;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: espacios.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TopLocaciones(espacio: espacios[index], user: usuario),
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

  Widget _carruselServicio(UserModel usuario) {
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
                          name: 'Personal',
                          onPressed: 3,
                          usuario: usuario,
                          imagenIcono: "assets/img/personalIcon.png",
                          colorfondo: Color.fromRGBO(27, 155, 170, 1.0),
                        ),
                        ElementoMenu(
                          name: 'Espacios',
                          onPressed: 5,
                          usuario: usuario,
                          imagenIcono: "assets/img/locationIcon.png",
                          colorfondo: Color.fromRGBO(204, 190, 176, 1.0),
                        ),
                        ElementoMenu(
                          name: 'Contratos',
                          onPressed: 4,
                          usuario: usuario,
                          imagenIcono: "assets/img/contractIcon.png",
                          colorfondo: Color.fromRGBO(255, 211, 78, 1.0),
                        ),

                        //elementoMenu(usuario,'Catering'),
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
