import 'package:flutter/material.dart';


class PresupuestoPage extends StatefulWidget {
  PresupuestoPage({Key key}) : super(key: key);

  @override
  _PresupuestoPageState createState() => _PresupuestoPageState();
}

class _PresupuestoPageState extends State<PresupuestoPage> {
  
  double _valorActores=100.0;
  double _valorTecnico=100.0;
  double _valorEquipo=100.0;
  double _presupuesto=0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
          child: Scaffold(
        appBar: AppBar(
                  title: Text(
                    'Presupuesto',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
                  ),
        ),
        body: Container(
           decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/background.jpg"),
          fit: BoxFit.cover,
          )),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children:[
                _ingresarPresupuesto()
              ] 
              ),
          )
          ),
        
      ),
    );
  }

  Widget _ingresarPresupuesto() {

    return Container(
      child: Column(
        children: [ 
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('Ingrese su presupuesto',
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
                        _amount(),
                        SizedBox(height: 10),
                        _sliders(),
                        SizedBox(height: 10),

                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                  padding:
                  EdgeInsets.only(right: 10.0, left: 10 ,  bottom: 30.0),
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text('Optimizar Presupuesto',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0),
                            fontWeight: FontWeight.bold)),
                    textColor: Colors.white,
                    color: Color.fromRGBO(112, 252, 118, 0.8),
                    onPressed: () {
                     
                    },
                  ),
                ))
        ],
      ),
    );
  }

  Widget _amount() {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0,bottom: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          initialValue: "",
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Presupuesto',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            // helperText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => _presupuesto = double.tryParse(value),
          validator: (value) {
            if (value.length==0) {
              return 'Ingrese un valor';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _sliders() {
    return Column(
      children: [
        SizedBox(
         child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(227, 227, 227, 1),),
                        height: 45,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 30.0,

                        margin: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0
                        ),
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,

                        ),
                        child: Text("Actores",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
        Slider(
          activeColor: Colors.indigoAccent,
          label: 'Actores',
          divisions: 20,
          value: _valorActores,
          min: 10.0,
          max: 400.0,
          onChanged: (opt){
            setState((){
              _valorActores=opt;

            });
          },
       ),
       SizedBox(
         child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(227, 227, 227, 1),),
                        height: 45,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 30.0,

                        margin: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0
                        ),
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,

                        ),
                        child: Text("Personal Tecnico",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
       Slider(
          activeColor: Colors.indigoAccent,
          label: 'Personal Tecnico',
          divisions: 20,
          value: _valorTecnico,
          min: 10.0,
          max: 400.0,
          onChanged: (opt){
            setState((){
              _valorTecnico=opt;
            });
          },
       ),
       SizedBox(
         child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(227, 227, 227, 1),),
                        height: 45,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 30.0,

                        margin: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0
                        ),
                        padding: EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,

                        ),
                        child: Text("Equipos",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
       Slider(
          activeColor: Colors.indigoAccent,
          label: 'Equipos',
          divisions: 20,
          value: _valorEquipo,
          min: 10.0,
          max: 400.0,
          onChanged: (opt){
            setState((){
              _valorEquipo=opt;
            });
          },
       ),

      ],
    );
    
  }
}