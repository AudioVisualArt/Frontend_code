import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectDetails extends StatefulWidget {
  final UserModel user;
  ProjectDetails({Key key, this.user}) : super(key: key);
  @override
  _ProjectDetails createState() => _ProjectDetails();
}

class _ProjectDetails extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    ProjectModel proyecto = ModalRoute.of(context).settings.arguments;
    final List<Widget> _screens = [];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Proyectos',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 30.0,
          padding: EdgeInsets.only(
            right: 15.0,
            left: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Center(
                      child: Text('Proyecto - ${proyecto.proyectName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(115, 115, 115, 1.0),
                              fontSize: 17.5,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold)))),
              SizedBox(
                height: 18,
              ),

              Container(
                padding: EdgeInsets.only(left: 10, bottom: 4),
                child: Text('Descripcion de la obra',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 51, 51, 0.8),
                        fontSize: 20.5,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold)),
              ),
              _descriptionCard(proyecto.description),
              //_contactCard(proyecto.contacto),
              Padding(
                padding: EdgeInsets.only(
                  top: 19,
                ),
                child: RaisedButton(
                  //splashColor: Colors.green,
                  padding:
                      EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('Posiciones Disponibles',
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

              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 19,
                  ),
                  child: RaisedButton(
                    //splashColor: Colors.green,
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                      borderRadius: BorderRadius.circular(15.0),
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

              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 19,
                  ),
                  child: RaisedButton(
                    //splashColor: Colors.green,
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text('Finanzas',
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

              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 19,
                  ),
                  child: RaisedButton(
                    //splashColor: Colors.green,
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text('Contacto',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionCard(String description) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(
            top: 1,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
            decoration: BoxDecoration(
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

  Widget _contactCard(String contact) {
    return Card(
        elevation: 20.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(children: <Widget>[
          ListTile(
            title: Text('Contacto',
                style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
            subtitle: Text(contact,
                style: TextStyle(fontSize: 12.0, fontFamily: "Raleway")),
          )
        ]));
  }
}
