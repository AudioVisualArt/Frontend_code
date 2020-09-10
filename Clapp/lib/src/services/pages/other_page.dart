import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  final UserModel user;
  OtherPage({Key key, this.user}) : super(key: key);

  @override
  _OtherPage createState() => _OtherPage();
}

class _OtherPage extends State<OtherPage> {
  final proyectosProvider = new ProyectosProvider();

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contratos Disponibles',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body:SingleChildScrollView(
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
                      TitleBar('Contratos'),

                      SizedBox(height: 9),
                      SizedBox(
                        height: 450,
                        child: _crearListado(usuario.id),
                      ),

                      SizedBox(height: 20),

                    ],
                  )))) ,
    );
  }
  Widget _crearListado(String idUsuario) {
    return FutureBuilder(
      future: proyectosProvider.cargarTodosProyectos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        if (snapshot.hasData) {
          final contratos = snapshot.data;
          return ListView.builder(

            // padding: const EdgeInsets.all(8.0),
            itemCount: contratos.length,
            /*itemBuilder: (context, index) =>
                _crearcontrato(context, contratos[index]),*/

          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}