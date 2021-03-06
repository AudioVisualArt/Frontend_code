import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/material.dart';

class VerContratosRecibidos extends StatefulWidget {
  final UserModel user;
  VerContratosRecibidos({Key key, this.user}) : super(key: key);
  @override
  _VerContratosRecibidos createState() => _VerContratosRecibidos();
}

class _VerContratosRecibidos extends State<VerContratosRecibidos> {
  final contratosProvider = new ContratosProvider();

  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Container(
        child: Scaffold(

          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/mostraritems.jpg"),
                    fit: BoxFit.cover,
                  )),

              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 30.0,
                  padding: EdgeInsets.only(
                    right: 1.0,
                    left: 1.0,
                  ),

                  //key: formKey,
                  child: Column(
                    children: <Widget>[
                      newappbar(user),

                      //SizedBox(height: 9),
                      Expanded(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 10.0,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height - 210,
                          child: _crearListado(user.id),
                        ),
                      )
                    ],
                  ))
          ),
          //floatingActionButton: _crearContrato(project),
          //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }


  Widget newappbar(UserModel user) {
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
                tileMode: TileMode.clamp
            )
        ),


        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(child: Padding(
                  padding: const EdgeInsets.only(left: 7.0, right: 20, top: 37),

                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Color.fromRGBO(115, 115, 115, 1.0),
                    onPressed: () => Navigator.pop(context, false),),
                ),),

                Container(child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 20, top: 37),
                  child: Text('Contratos',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(115, 115, 115, 1.0))),

                ),),
                Padding(
                  padding: EdgeInsets.only(left: 80.0, right: 7, top: 37),

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
                    IconButton(iconSize: 22,
                      icon: Icon(Icons.autorenew),
                      onPressed: () {
                        setState(() {
                          _crearListado(user.id);
                        });
                      },
                    ),
                  ],
                )
            ),
          ],
        )

    );
  }



  Widget _crearListado(String idUsuario) {
    return FutureBuilder(
      future: contratosProvider.cargarContratosOfrecidos(idUsuario),
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