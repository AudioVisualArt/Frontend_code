import 'package:Clapp/src/Finance/Model/Finance.dart';
import 'package:Clapp/src/Finance/provider/finances_provider.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
class NewGoal extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewGoal();
  }

}

class _NewGoal extends State<NewGoal>{
  FinanceModel finanza = new FinanceModel();
  FinancesProvider financesProvider= new FinancesProvider();

  @override
  Widget build(BuildContext context) {
    ProjectModel proyecto = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Nueva recaudación',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "Raleway",
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                    )),
                //background:
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('Complete los datos',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 17.5, fontFamily: "Raleway"))),
                Container(
                  padding: EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                  child: Form(
                    //key: formKey,

                    child: Column(
                      children: <Widget>[
                        _nombreDonacion(),
                        _pago()

                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding:
                      EdgeInsets.only(right: 10.0, left: 210,  bottom: 30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('Añadir',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                          finanza.projectId = proyecto.id;
                          financesProvider.crearFinance(finanza);
                          Navigator.popAndPushNamed(context, 'finances',
                              arguments: proyecto);
                        },
                      ),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
  Widget _nombreDonacion() {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: Center(
            child: TextFormField(
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Raleway",
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
              maxLength: 29,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  labelText: 'Nombre de la financiación',
                  labelStyle: TextStyle(
                    //color: Color.fromRGBO(0, 51, 51, 0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  helperText: "Ejemplo: La Universidad De Cine",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                      borderRadius: BorderRadius.circular(16.0))),
              onChanged: (value) => finanza.title = value,
              validator: (value) {
                if (value.length < 3) {
                  return 'Ingrese minimo 5 palabras';
                } else {
                  return null;
                }
              },
            )));
  }
  Widget _pago() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          //initialValue: contrato.payment.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 10,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Valor de recaudo',
            labelStyle: TextStyle(
              //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "200.000",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => finanza.quantity = double.parse(value),
          validator: (value) {
            if (utils.isNumeric(value)) {
              return null;
            } else {
              return 'Solo numeros';
            }
          },
        ),
      ),
    );
  }

}