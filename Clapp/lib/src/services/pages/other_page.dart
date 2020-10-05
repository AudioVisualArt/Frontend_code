import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/pages/contract_details.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
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
  final contratosProvider = new ContratosProvider();

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contratos Disponibles',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: SingleChildScrollView(
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
                        height: 1000,
                        child: _crearListado(usuario.id, usuario),
                      ),



                    ],
                  )))),
    );
  }

  Widget _crearListado(String idUsuario, UserModel usuario) {
    return FutureBuilder(
      future: proyectosProvider.cargarTodosProyectos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProjectModel>> snapshot) {
        if (snapshot.hasData) {
          final proyectos = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            // padding: const EdgeInsets.all(8.0),
            itemCount: proyectos.length,
            itemBuilder: (context, index) =>
                _crearproyectos(context, proyectos[index], usuario),

          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearproyectos(BuildContext context, ProjectModel project, UserModel usuario) {
    return Card(
          //margin: EdgeInsets.all(10),

          elevation: 10.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          // color: Color.fromRGBO(227, 227, 227, 1.0),
          child: Column(
            children: <Widget>[
              TitleBar(project.proyectName),
              FutureBuilder(
                future:contratosProvider.cargarContratosProoyecto(project.id),
                builder: (BuildContext context,
                AsyncSnapshot<List<ContractModel>> snapshot) {
              if (snapshot.hasData) {
                final contratos = snapshot.data;
                return ListView.builder(

              // padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                itemCount: contratos.length,
                itemBuilder: (context, index) =>
                    _crearcontrato(context, contratos[index],usuario),

              );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } ,
          )


            ],
          ),
        );
  }
  Widget _crearcontrato(BuildContext context, ContractModel contrato, UserModel usuario) {
    return  Card(
          //margin: EdgeInsets.all(10),

          elevation: 10.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          // color: Color.fromRGBO(227, 227, 227, 1.0),
          child:ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ContractDetails(
                        contrato,
                        usuario)),
              );
            },
                title: Text('${contrato.jobPosition} - ${contrato.workHours} horas',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                subtitle: Text(contrato.city,
                    style: TextStyle(fontSize: 15.0, fontFamily: "Raleway")),
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




        );
  }
}