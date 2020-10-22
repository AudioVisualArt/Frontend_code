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
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/img/mostraritems.jpg"),
        fit: BoxFit.cover,
      )),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 30.0,
          padding: EdgeInsets.only(
            right: 1.0,
            left: 1.0,
          ),

          //key: formKey,
          child: Column(
            children: <Widget>[
              newappbar(usuario.id, usuario),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  child: _crearListado(usuario.id, usuario),
                  width: MediaQuery.of(context).size.width - 10.0,
                  height: MediaQuery.of(context).size.height - 150,
                ),
              )),
              /*TitleBar('Contratos'),

                        SizedBox(height: 9),
                        SizedBox(
                          height: 1000,
                          child: _crearListado(usuario.id, usuario),
                        ),


                         */
            ],
          )),
    ));
  }

  Widget _crearListado(String idUsuario, UserModel usuario)  {
    return FutureBuilder(
      future: proyectosProvider.cargarTodosProyectos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        if (snapshot.hasData) {
          final proyectos = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            // padding: const EdgeInsets.all(8.0),
            itemCount: proyectos.length,
            itemBuilder: (context, index) {
                  return FutureBuilder(
                  future: contratosProvider.cargarContratosProoyecto(proyectos[index].id),
                  builder:(BuildContext context, AsyncSnapshot<List<ContractModel>> snapshot) {
                    
                    if (snapshot.hasData) {
                      List<ContractModel> aux=snapshot.data;
                      if(aux.isNotEmpty){
                         return _crearproyectos(
                            context, proyectos[index], usuario);
                      }else{
                        return Container(

                        );
                      }
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                     
                  }
                  );
              } 
          
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearproyectos(
      BuildContext context, ProjectModel project, UserModel usuario) {
    return Card(
      color: Colors.white60.withOpacity(0.9),
      //margin: EdgeInsets.all(10),

      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      // color: Color.fromRGBO(227, 227, 227, 1.0),
      child: Column(
        children: <Widget>[
          TitleBar(project.proyectName),
          FutureBuilder(
            future: contratosProvider.cargarContratosProoyecto(project.id),
            builder: (BuildContext context,
                AsyncSnapshot<List<ContractModel>> snapshot) {
              if (snapshot.hasData) {
                final contratos = snapshot.data;
                return ListView.builder(
                  // padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: contratos.length,
                  itemBuilder: (context, index) =>
                      _crearcontrato(context, contratos[index], usuario),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }

  Widget _crearcontrato(
      BuildContext context, ContractModel contrato, UserModel usuario) {
    return Card(
      //margin: EdgeInsets.all(10),

      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // color: Color.fromRGBO(227, 227, 227, 1.0),
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => ContractDetails(contrato, usuario),
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

  Widget newappbar(String idUsuario, UserModel usuario) {
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 7.0, right: 20, top: 37),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 37),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text('Contratos Disponibles',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0))),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Todo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(115, 115, 115, 1.0),
                            fontSize: 17.5,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      iconSize: 22,
                      icon: Icon(Icons.autorenew),
                      onPressed: () {
                        setState(() {
                          _crearListado(usuario.id, usuario);
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
