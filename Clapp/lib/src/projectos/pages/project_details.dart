import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/material.dart';

class ProjectDetails extends StatefulWidget {
  final UserModel user;
  ProjectDetails({Key key, this.user}) : super(key: key);
  @override
  _ProjectDetails createState() => _ProjectDetails();
}

class _ProjectDetails extends State<ProjectDetails>{
  @override

  Widget build(BuildContext context) {
    ProjectModel proyecto= ModalRoute.of(context).settings.arguments;
    final List<Widget> _screens = [

    ];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(proyecto.proyectName,
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
          ),
        body: Column(
          children: <Widget>[
            _descriptionCard(proyecto.description),
            _contactCard(proyecto.contacto),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              label: Text('Contratos abiertos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
              textColor: Colors.white,
              icon: Icon(Icons.description, color: Colors.white),
              color: Color.fromRGBO(89, 122, 121, 1.0),
              padding: EdgeInsets.symmetric(horizontal: 45.5),
              onPressed: () {
                Navigator.pushNamed(context, 'see_contracts',
                    arguments: proyecto);
              },
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              label: Text('Contratados',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
              textColor: Colors.white,
              icon: Icon(Icons.accessibility, color: Colors.white),
              color: Color.fromRGBO(89, 122, 121, 1.0),
              padding: EdgeInsets.symmetric(horizontal: 72.5),
              onPressed: () {
                //Navigator.push();
              },
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              label: Text('Financiación',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
              textColor: Colors.white,
              icon: Icon(Icons.attach_money, color: Colors.white),
              color: Color.fromRGBO(89, 122, 121, 1.0),
              padding: EdgeInsets.symmetric(horizontal: 70.5),
              onPressed: () {
                //Navigator.push();
              },
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              label: Text('Servicios adquiridos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
              textColor: Colors.white,
              icon: Icon(Icons.assignment_turned_in, color: Colors.white),
              color: Color.fromRGBO(89, 122, 121, 1.0),
              padding: EdgeInsets.symmetric(horizontal: 35.5),
              onPressed: () {
                //Navigator.push();
              },
            ),
          ],
        ),
        ),
      );

  }

  Widget _descriptionCard(String description){
    return Card(
      elevation: 20.0,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
          children: <Widget>[
      ListTile(
      title: Text('Descripcion',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
      subtitle: Text(description,
          style: TextStyle(fontSize: 12.0, fontFamily: "Raleway")),
      )
          ]
      )
    );
  }

  Widget _contactCard(String contact){
    return Card(
        elevation: 20.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Contacto',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                subtitle: Text(contact,
                    style: TextStyle(fontSize: 12.0, fontFamily: "Raleway")),
              )
            ]
        )
    );
  }
}