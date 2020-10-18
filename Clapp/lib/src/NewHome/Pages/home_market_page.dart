import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/NewHome/Pages/recomendados_market.dart';
import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/ScreenPlay/Provider/screenplay_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image(
                        image: AssetImage('assets/img/no-image.png'),
                        fit: BoxFit.cover,
                        width: 60.0,
                        height: 60.0,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30, bottom: 20),
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
            )
          ],
        ),
      ),
    );
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
          return

            ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: equipos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _GuionBanner(context, equipos[index]),
                  );
                })
          ;
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
                      child: Text(guion.titulo+",",

                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(100, 100, 110, 1),
                            fontWeight: FontWeight.bold
                          )),
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
                  Text("Genero: "+guion.topic,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Raleway",
                        color: Colors.black87,
                        //fontWeight: FontWeight.bold
                      )),

                ],
              )
            ),

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
}
