import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'file:///E:/Tesis_Code/Clapp/lib/src/Contract/pages/new_contract.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';

class VerContratos extends StatefulWidget {
  final UserModel user;
  VerContratos({Key key, this.user}) : super(key: key);
  @override
  _VerContratos createState() => _VerContratos();
}

class _VerContratos extends State<VerContratos> {
  final contratosProvider = new ContratosProvider();

  @override
  Widget build(BuildContext context) {
    //final idUsuario = ModalRoute.of(context).settings.arguments;
    UserModel user = ModalRoute.of(context).settings.arguments;
    return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Project Management',
                style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.autorenew),
                onPressed: () {
                  setState(() {
                    _crearListado(user.id);
                  });
                },
              ),
            ],
          ),
            body:
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
                            TitleBar('Contracts'),

                            SizedBox(height: 9),
                            SizedBox(
                              height: 450,
                              child: _crearListado(user.id),
                            ),

                            SizedBox(height: 20),
                            RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              label: Text('Create New Contract',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: "Raleway")),
                              textColor: Colors.white,
                              icon: Icon(
                                Icons.work,
                                color: Colors.white,
                              ),
                              color: Color.fromRGBO(89, 122, 121, 1.0),
                              onPressed: () {
                                Navigator.pushNamed(context, 'new_contract',
                                    arguments: user);
                              },
                            ),
                          ],
                        ))))


        )
        );

  }

  Widget _crearListado(String idUsuario) {
    return FutureBuilder(
      future: contratosProvider.cargarContratosPropietario(idUsuario),
      builder: (BuildContext context, AsyncSnapshot<List<ContractModel>> snapshot) {
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
                title: Text('${contrato.city} - ${contrato.workHours}',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                subtitle: Text(contrato.id,
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
