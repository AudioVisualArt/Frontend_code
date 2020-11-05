import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';


class PresupuestoPage extends StatefulWidget {
  PresupuestoPage({Key key}) : super(key: key);

  @override
  _PresupuestoPageState createState() => _PresupuestoPageState();
}

class _PresupuestoPageState extends State<PresupuestoPage> {
  List<double> _valores = new List();
  List<dynamic> args=new List();
  PageController pc=new PageController();
  int _valorActores=0;
  int _valorTecnico=0;
  int _valorEquipo=0;
  int _valorEspacios=0;
  int _valorArte=0;
  int _presupuesto=0;
  @override
  Widget build(BuildContext context) {
    UserModel user=ModalRoute.of(context).settings.arguments;
   if(args.length==0){
     args.add(user);
   }
    
    
    return Container(
          child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
                  title: Text(
                    'Presupuesto',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
                  ),
        ),
        body: GestureDetector(
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: pc,
            children: [
              _pagina1(),
              _pagina2()
            ],
          ),
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        )
        
       
        
      ),
    );
  }
  
  Widget _amount() {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0,bottom: 20.0),
      child: Column(
              children:[
                Center(child: Text('Para empezar ingresa tu presupuesto', style: TextStyle(fontSize: 17.5,fontFamily: "Raleway"),),),
                SizedBox(height: 10.0,),
                    Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: Colors.white
                ),
                child: TextFormField(
                  
                  keyboardType: TextInputType.number,
                  initialValue: "",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Raleway",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
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
                  onChanged: (value) => _presupuesto = int.tryParse(value),
                  onEditingComplete: (){
                    pc.animateToPage(2, duration: Duration(milliseconds: 1000), curve: Curves.linear);
                  },
                  validator: (value) {
                    if (value.length==0) {
                      return 'Ingrese un valor';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
              ] 
      ),
    );
  }

  Widget _sliders() {
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(left:10.0,right: 10.0),
          child: Text("Asigna un porcetanje de tu presupuesto de acuerdo a la importancia de cada item en tu proyecto",
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 15.5, fontStyle: FontStyle.italic)),
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
                        child: Text("Actores: \u0024 ${((this._valorActores/100)*this._presupuesto)}",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
        Slider(
          activeColor: Colors.black,
          label: '${this._valorActores}%',
          divisions: 20,
          value: _valorActores.toDouble(),
          min: 0.0,
          max: 100.0,
          onChanged: (this._presupuesto==0.0) ? null : (opt){
            setState((){
              if((_valorEspacios+_valorTecnico+_valorEquipo+_valorArte+opt)<=100){
                _valorActores=opt.toInt();
              }
              

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
                        child: Text("Personal Tecnico: \u0024 ${((this._valorTecnico/100)*this._presupuesto)}",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
       Slider(
          activeColor: Colors.black,
          label: '${this._valorTecnico}%',
          divisions: 20,
          value: _valorTecnico.toDouble(),
          min: 0.0,
          max: 100.0,
          onChanged: (this._presupuesto==0.0) ? null : (opt){
            setState((){
               if((_valorEspacios+opt+_valorEquipo+_valorArte+_valorActores)<=100){
              _valorTecnico=opt.toInt();
               }
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
                        child: Text("Equipos: \u0024 ${((this._valorEquipo/100)*this._presupuesto)}",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
       Slider(
          activeColor: Colors.black,
          label: '${this._valorEquipo}%',
          divisions: 20,
          value: _valorEquipo.toDouble(),
          min: 0.0,
          max: 100.0,
          onChanged:(this._presupuesto==0.0) ? null : (opt){
            setState((){
               if((_valorEspacios+_valorTecnico+opt+_valorArte+_valorActores)<=100){
              _valorEquipo=opt.toInt();
               }
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
                        child: Text("Espacios: \u0024 ${((this._valorEspacios/100)*this._presupuesto)}",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
        Slider(
          activeColor: Colors.black,
          label: '${this._valorEspacios}%',
          divisions: 20,
          value: _valorEspacios.toDouble(),
          min: 0.0,
          max: 100.0,
          onChanged: (this._presupuesto==0.0) ? null : (opt){
            setState((){
               if((opt+_valorTecnico+_valorEquipo+_valorArte+_valorActores)<=100){
              _valorEspacios=opt.toInt();
               }

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
                        child: Text("Arte: \u0024 ${((this._valorArte/100)*this._presupuesto)}",
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


            ),
        ),
        Slider(
          activeColor: Colors.black,
          label: '${this._valorArte}%',
          divisions: 20,
          value: _valorArte.toDouble(),
          min: 0.0,
          max: 100.0,
          onChanged: (this._presupuesto==0.0) ? null : (opt){
            setState((){
               if((_valorEspacios+_valorTecnico+_valorEquipo+opt+_valorActores)<=100){
              _valorArte=opt.toInt();
               }

            });
          },
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
                    color: Color.fromRGBO(110, 164, 129,1.0),
                    onPressed: () {
                      if((_valorEspacios+_valorTecnico+_valorEquipo+_valorArte+_valorActores)==100){
                        this._valores.clear();
                        this._valores.add((this._presupuesto)*(this._valorActores/100));
                        this._valores.add((this._presupuesto)*(this._valorTecnico/100));
                        this._valores.add((this._presupuesto)*(this._valorEquipo/100));
                        this._valores.add((this._presupuesto)*(this._valorEspacios/100));
                        this._valores.add((this._presupuesto)*(this._valorArte/100));
                        args.add(this._valores);            
                       Navigator.pushNamed(context, 'recomendado',arguments: args);

                      }
                    },
                  ),
                ),
       )

      ],
    );
    
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(89, 159, 112  ,1.0),
    );
  }

  Widget _boxPresupuesto() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ 
                Container(
                  padding: EdgeInsets.only(top: 15.0,left: 30.0,right: 30.0),
                  child: Text('Clap te ayuda a gestionar tus recursos de la mejor manera de acuerdo a tus objetivos principales',
                  textAlign: TextAlign.center,
                  style:TextStyle(fontSize: 23.5, fontStyle: FontStyle.italic))
                ),
                _amount(),
                Icon(Icons.arrow_drop_down_circle, color: Colors.black,)
                
        ]
    );
  }

  Widget _pagina1() {
    return  
        Container(
          height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/homeback2.jpg"),
              fit: BoxFit.cover,
            )),
          child: Stack(
            children:[
              _boxPresupuesto(),
            ] 
          ),
        );
  }

  Widget _pagina2() {
    return Stack(
      children: [
        _colorFondo2(),
        _sliders()
      ],
    );
  }

  Widget _colorFondo2() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(
 100, 127, 156,1),
    );
  }
}
