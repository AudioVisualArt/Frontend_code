import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';

class VerContratos extends StatefulWidget {
  final ProjectModel user;
  VerContratos({Key key, this.user}) : super(key: key);
  @override
  _VerContratos createState() => _VerContratos();
}

class _VerContratos extends State<VerContratos> {
  final contratosProvider = new ContratosProvider();

  @override
  Widget build(BuildContext context) {
    //final idUsuario = ModalRoute.of(context).settings.arguments;
    ProjectModel project = ModalRoute.of(context).settings.arguments;
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Ver contratos',
            style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                _crearListado(project.id);
              });
            },
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/mostraritems.jpg"),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 30.0,
                  padding: EdgeInsets.only(
                    right: 1.0,
                    left: 1.0,
                  ),
                  child: Form(
                    //key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text('Contratos Disponibles',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontSize: 17.5,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold))),
                          SizedBox(height: 9),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 10.0,
                            height: MediaQuery.of(context).size.height - 135.0,
                            child: _crearListado(project.id),
                          ),
                        ],
                      )))
          )),
      floatingActionButton: _crearContrato(project),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    ));
  }

  Widget _crearContrato(ProjectModel project) {
    return RaisedButton(
      splashColor: Colors.green,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text('Contrato nuevo',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(115, 115, 115, 1.0),
              fontWeight: FontWeight.bold)),
      textColor: Colors.white,
      color: Color.fromRGBO(112, 252, 118, 0.8),
      onPressed: () {
        Navigator.pushNamed(context, 'new_contract', arguments: project);
      },
    );
  }

  Widget _crearListado(String idUsuario) {
    return FutureBuilder(
      future: contratosProvider.cargarContratosProoyecto(idUsuario),
      builder:
          (BuildContext context, AsyncSnapshot<List<ContractModel>> snapshot) {
        if (snapshot.hasData) {
          final contratos = snapshot.data;
          return ListView.builder(
            // padding: const EdgeInsets.all(8.0),
            itemCount: contratos.length,
            itemBuilder: (context, index) =>
                _crearcontrato(context, contratos[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearcontrato(BuildContext context, ContractModel contrato) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          contratosProvider.borrarContrato(contrato.id);
        },
        child: Card(
          //margin: EdgeInsets.all(10),

          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          // color: Color.fromRGBO(227, 227, 227, 1.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                    '${contrato.jobPosition} - ${contrato.workHours} horas',
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
            ],
          ),
        ));
  }
}
