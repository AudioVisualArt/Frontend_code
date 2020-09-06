import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:flutter/material.dart';

class VerColaboradores extends StatefulWidget {
  final ProjectModel project;
  VerColaboradores({Key key, this.project}) : super(key: key);
  @override
  _VerColaboradores createState() => _VerColaboradores();
}

class _VerColaboradores extends State<VerColaboradores> {
  final proyectosProvider = new ProyectosProvider();

  @override
  Widget build(BuildContext context) {
    ProjectModel projectModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contratos aceptados',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: _crearColaboradores(context, projectModel),
    );
  }


Widget _crearColaboradores(BuildContext context, ProjectModel projectModel){
  return SingleChildScrollView(
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
                  TitleBar('Colaboradores'),
                  SizedBox(height: 9),
                  SizedBox(
                    height: 450,
                    child: _crearListado(projectModel.id),
                  ),
                  SizedBox(height: 5),

                ],
              )
          )
      )
  );;
}

Widget _crearListado(projectId) {
  return FutureBuilder(
    future: proyectosProvider.cargarColaboradores(projectId),
    builder:
        (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
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
  Widget _crearProyecto(BuildContext context, UserModel user) {
    return Card(
            elevation: 20.0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('${user.name}',
                      style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
                  subtitle: Text(user.description,
                      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway")),

                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                        child: Text('Details ->',
                            style:
                            TextStyle(fontSize: 15.0, fontFamily: "Raleway")),
                        onPressed: () => Navigator.pushNamed(context, 'details_project',
                            arguments: proyecto)

                    ),
                  ],
                )*/
              ],
            )
        );
  }

}