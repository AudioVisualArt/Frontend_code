import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/services/pages/audiovisual_page.dart';
import 'package:Clapp/src/services/pages/contratar_page.dart';
import 'package:Clapp/src/services/pages/equipment_page.dart';
import 'package:Clapp/src/services/pages/new_service.dart';
import 'package:Clapp/src/services/pages/other_page.dart';
import 'package:Clapp/src/services/pages/personel_page.dart';
import 'package:Clapp/src/services/pages/spaces_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesPages extends StatefulWidget {
  final UserModel user;
  ServicesPages({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ServicesPages();
  }
}

class _ServicesPages extends State<ServicesPages> {

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Servicios',
              style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _MenuServicios(usuario),
              ),


            ],
          ),
        ));
  }

  Widget _MenuServicios(UserModel usuario) {
    return  Padding(padding: EdgeInsets.only(right: 10.0, left: 10.0,),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            opcionesMenu1(context, usuario),
            opcionesMenu3(),
            opcionesMenu4(),
            opcionesMenu2(usuario),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only( bottom: 35.0),
              child: RaisedButton(
                padding:
                EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text('Nuevo servicio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        color: Color.fromRGBO(115, 115, 115, 1.0),
                        fontWeight: FontWeight.bold)),
                textColor: Colors.white,
                color: Color.fromRGBO(112, 252, 118, 0.8),
                onPressed: (){
                  Navigator.pushNamed(context, 'new_service',
                      arguments: usuario);
                },
              ),
            )
          ],
        )
      );




  }

  Widget opcionesMenu2(UserModel usuario) {
    return Card(
        margin: EdgeInsets.only(top: 15),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'open_contracts',
                  arguments: usuario);
            },
            child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0.0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                          blurRadius: 0.3,
                          //offset: Offset(0,6),
                        )
                      ]),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 200.0,
                            width: 195.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/img/Contratos.PNG"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60, left: 43),
                          ),
                          Container(
                            child: Text(
                              "Contratos",
                              style: TextStyle(
                                  fontSize: 23.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(115, 115, 115, 1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }

  Widget opcionesMenu1(BuildContext context, UserModel usuario) {
    return Card(
        margin: EdgeInsets.only(top: 15),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: InkWell(
            onTap: () {
             /* Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PersonelPage()));

              */

             Navigator.pushNamed(context, 'personal',
                        arguments: usuario);


            },
            child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0.0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                          blurRadius: 0.3,
                          //offset: Offset(0,6),
                        )
                      ]),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 200.0,
                            width: 195.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/img/personal.PNG"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 60, left: 180),
                              ),
                              Container(
                                child: Text(
                                  "Personal",
                                  style: TextStyle(
                                      fontSize: 23.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Disponible",
                                  style: TextStyle(
                                      fontSize: 23.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ))));
  }

  Widget opcionesMenu3() {
    return Card(
        margin: EdgeInsets.only(top: 15),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new EquipmentPage()));
            },
            child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0.0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                          blurRadius: 0.3,
                          //offset: Offset(0,6),
                        )
                      ]),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 200.0,
                            width: 195.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/img/audiovisual1.PNG"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60, left: 43),
                          ),
                          Container(
                            child: Text(
                              "Equipo",
                              style: TextStyle(
                                  fontSize: 23.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(115, 115, 115, 1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }

  Widget opcionesMenu4() {
    return Card(
        margin: EdgeInsets.only(top: 15),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SpacesPage()));
            },
            child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0.0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                          blurRadius: 0.3,
                          //offset: Offset(0,6),
                        )
                      ]),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 200.0,
                            width: 195.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/img/espacios.PNG"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60, left: 43),
                          ),
                          Container(
                            child: Text(
                              "Espacios",
                              style: TextStyle(
                                  fontSize: 23.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(115, 115, 115, 1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
