import 'package:Clapp/src/projectos/pages/new_project_page.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/projectos/pages/new_project_page.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/MyStudio/pages/new_contract.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final proyectosProvider = new ProyectosProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: _createproject(context),
    );
  }


  Widget _createproject(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
      SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 15.0,
              ),
              child: Form(
                //key: formKey,
                  child: Column(
                    children: <Widget>[
                      TitleBar('All projects'),

                      SizedBox(height: 9),
                      SizedBox(
                        height: 450,
                        child: _crearListado(),
                      ),

                      SizedBox(height: 10),
                      RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        label: Text('New Project',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: "Raleway")),
                        textColor: Colors.white,
                        icon: Icon(
                          Icons.create_new_folder,
                          color: Colors.white,
                        ),
                        color: Color.fromRGBO(89, 122, 121, 1.0),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new NewProjectPage()));
                        },
                      ),
                    ],
                  ))));




  }

  Widget _crearListado() {
    return FutureBuilder(
      future: proyectosProvider.cargarProyectos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        if (snapshot.hasData) {
          final projectos = snapshot.data;
          return ListView.builder(
            itemCount: projectos.length,
            itemBuilder: (context, index) =>
                _crearProyecto(context, projectos[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearProyecto(BuildContext context, ProjectModel proyecto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          proyectosProvider.borrarProyectos(proyecto.id);
        },
        child: Card(
          elevation: 20.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('${proyecto.proyectName}',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                subtitle: Text(proyecto.id,
                    style: TextStyle(fontSize: 10.0, fontFamily: "Raleway")),
                leading: Icon(Icons.arrow_forward_ios),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('Details',
                        style:
                        TextStyle(fontSize: 15.0, fontFamily: "Raleway")),
                    onPressed: () { Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new NewContract() )

                    );}
                  ),
                ],
              )

               */


            ],
          ),
        ));
  }



}

