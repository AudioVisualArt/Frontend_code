import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/pages/executive_summary_page.dart';
import 'package:Clapp/src/projectos/pages/main_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectDetails extends StatefulWidget {
  final UserModel user;
  ProjectDetails({Key key, this.user}) : super(key: key);
  @override
  _ProjectDetails createState() => _ProjectDetails();
}

class _ProjectDetails extends State<ProjectDetails> {
  List<dynamic> args=new List();
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    ProjectModel proyecto=args[1];
    final List<Widget> _screens = [];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/homeback2.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 30.0,
            padding: EdgeInsets.only(
              right: 2.0,
              left: 2.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  newappbar(proyecto),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, bottom: 4),
                      child: Text('Descripcion de la obra',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 51, 51, 0.8),
                              fontSize: 20.5,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  _descriptionCard(proyecto.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 19, left: 10, right: 10),
                          child: SizedBox(
                            height: 52,
                            width: 166,
                            child: RaisedButton(
                              //splashColor: Colors.green,
                              padding: EdgeInsets.only(
                                  top: 13, bottom: 13, left: 10, right: 10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 51, 51, 0.8),
                                    width: 1.2),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text('Contratos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontWeight: FontWeight.bold)),
                              textColor: Color.fromRGBO(0, 51, 51, 0.8),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'see_contracts',
                                    arguments: proyecto);
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 19, left: 10, right: 10),
                          child: SizedBox(
                            height: 52,
                            width: 166,
                            child: RaisedButton(
                              //splashColor: Colors.green,
                              padding: EdgeInsets.only(
                                  top: 13, bottom: 13, left: 10, right: 10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 51, 51, 0.8),
                                    width: 1.2),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text('Presupuesto',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontWeight: FontWeight.bold)),
                              textColor: Color.fromRGBO(0, 51, 51, 0.8),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'presupuesto',arguments: args[0]);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 19, left: 10, right: 10),
                          child: SizedBox(
                            height: 52,
                            width: 166,
                            child: RaisedButton(
                              //splashColor: Colors.green,
                              padding: EdgeInsets.only(
                                  top: 13, bottom: 13, left: 10, right: 10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 51, 51, 0.8),
                                    width: 1.2),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text('Colaboradores',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontWeight: FontWeight.bold)),
                              textColor: Color.fromRGBO(0, 51, 51, 0.8),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'collaborators',
                                    arguments: proyecto);
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 19, left: 10, right: 10),
                          child: SizedBox(
                            height: 52,
                            width: 166,
                            child: RaisedButton(
                              //splashColor: Colors.green,
                              padding: EdgeInsets.only(
                                  top: 13, bottom: 13, left: 10, right: 10),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(0, 51, 51, 0.8),
                                    width: 1.2),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text('Finanzas',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontWeight: FontWeight.bold)),
                              textColor: Color.fromRGBO(0, 51, 51, 0.8),
                              color: Colors.redAccent,
                              onPressed: () {
                                Navigator.popAndPushNamed(context, 'finances',
                                    arguments: proyecto);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 17),
                      child: Text("Documentos",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Raleway",
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: SizedBox(
                      height: 52,
                      width: MediaQuery.of(context).size.width - 40,
                      child: RaisedButton(
                        //splashColor: Colors.green,
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(0, 51, 51, 0.8),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text('Carpeta Madre',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(0, 51, 51, 0.8),
                                fontWeight: FontWeight.bold)),
                        textColor: Color.fromRGBO(0, 51, 51, 0.8),
                        color: Colors.white,
                        onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainFilePage(
                                  projectModel: proyecto,
                                )));},
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: SizedBox(
                      height: 52,
                      width: MediaQuery.of(context).size.width - 40,
                      child: RaisedButton(
                        //splashColor: Colors.green,
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(0, 51, 51, 0.8),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text('Carpeta Fondos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(0, 51, 51, 0.8),
                                fontWeight: FontWeight.bold)),
                        textColor: Color.fromRGBO(0, 51, 51, 0.8),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10, bottom: 15),
                    child: SizedBox(
                      height: 52,
                      width: MediaQuery.of(context).size.width - 40,
                      child: RaisedButton(
                        //splashColor: Colors.green,
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(0, 51, 51, 0.8),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text('Resumen Ejecutivo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(0, 51, 51, 0.8),
                                fontWeight: FontWeight.bold)),
                        textColor: Color.fromRGBO(0, 51, 51, 0.8),
                        color: Colors.white,
                        onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ExecutiveSummaryPage(
                          projectModel: proyecto,
                        )));},
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget newappbar(ProjectModel proyecto) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(252, 252, 252, 1),
                  Color.fromRGBO(252, 252, 252, 1),
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 6.0, right: 20, top: 37),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width- 365
                   //   50
                  ),
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 37),
                      child: Text('Proyecto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0))),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0),

              //mainAxisAlignment: MainAxisAlignment.center,

              child: Text('${proyecto.proyectName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      fontSize: 30,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  Widget _descriptionCard(String description) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 25,
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(top: 1, left: 5, right: 5),
          child: Container(
            padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                width: 1.3,
                color: Color.fromRGBO(0, 51, 51, 0.8),
              ),
            ),
            child: Text(description,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
