import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/MyStudio/pages/new_contract.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';

class VerContratos extends StatefulWidget {
  @override
  _VerContratos createState() => _VerContratos();
}

class _VerContratos extends State<VerContratos> {
  final contratosProvider = new ContratosProvider();

  @override
  Widget build(BuildContext context) {
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
                    _crearListado();
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
                            TitleBar('Actors'),

                            SizedBox(height: 9),
                            SizedBox(
                              height: 450,
                              child: _crearListado(),
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
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                        new NewContract()));
                              },
                            ),
                          ],
                        ))))


        )
        );

  }

  Widget _crearListado() {
    return FutureBuilder(
      future: contratosProvider.cargarContratos(),
      builder: (BuildContext context, AsyncSnapshot<List<ContractModel>> snapshot) {
        if (snapshot.hasData) {
          final contratos = snapshot.data;
          return ListView.builder(
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
          elevation: 20.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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