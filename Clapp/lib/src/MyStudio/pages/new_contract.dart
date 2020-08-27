import 'package:flutter/material.dart';

import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class NewContract extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewContract();
  }


}

class _NewContract extends State<NewContract>{

  final contractformkey = GlobalKey<FormState>();

 ContractModel contrato = new ContractModel();
  bool _guardando = false;
  var _selectedValue;
  var _categoriesJobPosition = List<DropdownMenuItem>();

  var _categoriesWorkDays = List<DropdownMenuItem>();

  var _categoriesPlace = List<DropdownMenuItem>();

  var _categoriesDesiredSkills = List<DropdownMenuItem>();

  final contratoProvider = new ContratosProvider();
  @override
  Widget build(BuildContext context) {

    final ContractModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      contrato = prodData;
    }
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(

          appBar: AppBar(
            title: Text('New Contract',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 50.0,

              ),
              child: Form(
                key: contractformkey,
                child: Column(

                  children: <Widget>[
                    _city(),
                    SizedBox(height: 25),
                    _jobPosition(),
                    SizedBox(height: 25),
                    _workDays(),



                    SizedBox(height: 25),
                    _payment(),
                    SizedBox(height: 25),
                    _desiredSkills(),
                    SizedBox(height: 45),
                    _botoncrearcontrato(),

                  ],
                ),
              ),
            ),
          ),


        ));
  }

  Widget _city() {
    return TextFormField(
      initialValue: contrato.city,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'City',
      ),
      onSaved: (value) => contrato.city = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de la ciudad correctamente';
        } else {
          return null;
        }
      },

    );
  }
  Widget _jobPosition(){
    return TextFormField(
      initialValue: contrato.jobPosition,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Job Position',
      ),
      onSaved: (value) => contrato.jobPosition = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre correctamente';
        } else {
          return null;
        }
      },

    );
  }

  Widget _workDays(){
    return TextFormField(
      initialValue: contrato.workHours.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Work Hours',
      ),
      onSaved: (value) => contrato.workHours = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }



  Widget _payment() {
    return TextFormField(
      initialValue: contrato.payment.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Payment',
      ),
      onSaved: (value) => contrato.payment = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _desiredSkills(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _categoriesDesiredSkills,
      hint: Text('Desired Skills'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }

  Widget _botoncrearcontrato(){
    return RaisedButton.icon(
      onPressed: (_guardando) ? null : _submit,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      label: Text('Open Contract',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
      textColor: Colors.white,
      icon: Icon(Icons.playlist_add_check,
        color: Colors.white,
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),


    );
  }

 void _submit() {
   if (!contractformkey.currentState.validate()) return;

   contractformkey.currentState.save();

   print('Todo Ok');

   setState(() {
     _guardando = true;
   });

   if (contrato.id == null) {
     contratoProvider.crearContrato(contrato);
   } else {
     contratoProvider.editarContrato(contrato);
   }

   // setState(() {
   //   _guardando = false;
   // });


   Duration(milliseconds: 1500);
   Navigator.pop(context, new MaterialPageRoute(
       builder: (context) =>
       new NewContract())

   );
   //Navigator.pushReplacementNamed(context, 'contrato');
 }
  }

