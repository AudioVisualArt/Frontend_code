import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:flutter/material.dart';

class ActividadPage extends StatefulWidget {
  ActividadPage({Key key}) : super(key: key);

  @override
  _ActividadPageState createState() => _ActividadPageState();
}

class _ActividadPageState extends State<ActividadPage> {
  UserModel user;
  List<ActividadModel> actividades=new List();
  ActividadProvider actividadProvider=new ActividadProvider();
  
  @override
  Widget build(BuildContext context) {
    user=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Actividad',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
      body: _actividades(),
          );
  }
      
  Widget _actividades() {
  
    return FutureBuilder(
      future: actividadProvider.cargarActividades(user.id),
      builder: (BuildContext context, AsyncSnapshot<List<ActividadModel>> snapshot) {
        if(snapshot.hasData){
          actividades=snapshot.data;
          return _crearTarjetas();

        }else{
          return Center(child: CircularProgressIndicator());
        }
        
      },
    );

  }

  Widget _crearTarjetas() {

    var fecha=new DateTime.now().toString();
    var fecha1=fecha.split(" ");

    print(fecha1[0]);
    return ListView.builder(
      itemCount: actividades.length,
      itemBuilder: (context,index){
        switch (actividades[index].tipo) {
          case 'Contrato': var str=actividades[index].fecha;
                          var str2=str.split(" ");
                          var str3=str2[1].split(".");
                          return InkWell(
                            onTap: (){
                              var tokens=actividades[index].contenido.split(",");
                             return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 600,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    ListTile(leading: Text("Ciudad: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[0])),
                                    ListTile(leading: Text("Posición: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),
                                    ListTile(leading: Text("Pago: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[2])),
                                    ListTile(leading: Text("Horas: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[3])),
                                    
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(237, 137, 127, 1),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[ 
                                  Text(str2[0]),
                                  SizedBox(height: 5.0),
                                  Row(
                                  children: [
                                    Icon(Icons.file_copy),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                                ),
                                ]
                              ),
                            ),
                          ); 
            
            break;
            case 'Proyecto': var str=actividades[index].fecha;
                              var str2=str.split(" ");
                              var str3=str2[1].split(".");
                            return InkWell(
                              onTap: (){
                                 var tokens=actividades[index].contenido.split(",");
                             return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 600,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    ListTile(leading: Text("Nombre: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[0])),
                                    ListTile(leading: Text("Tipo: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),
                                    SizedBox(height: 10,),
                                    Text("About: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10,),
                                    Text(tokens[2],textAlign: TextAlign.center),
                                    
                                    
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );
                              },
                              child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(95, 119, 245 , 1),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[ 
                                  Text(str2[0]), 
                                  SizedBox(height: 5.0),
                                  Row(
                                  children: [
                                    Icon(Icons.camera_roll),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                                ),
                                ]
                              ),
                          ),
                            ); 
                break;
              case 'Equipo': var str=actividades[index].fecha;
                              var str2=str.split(" ");
                              var str3=str2[1].split(".");
                            return InkWell(
                              onTap: (){
                                var tokens=actividades[index].contenido.split(",");
                             return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 500,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    ListTile(leading: Text("Nombre: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[0])),
                                    ListTile(leading: Text("Marca: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),
                                    ListTile(leading: Text("Valor: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),          
                                    
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );
                              },
                              child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(135, 202, 118  , 1),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                              child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[ 
                                  Text(str2[0]),
                                  SizedBox(height: 5.0),
                                  Row(
                                  children: [
                                    Icon(Icons.mic_external_on),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                                ),
                                ]
                              ),
                          ),
                            ); 
                break;
                case 'Mensaje': var str=actividades[index].fecha;
                                var str2=str.split(" ");
                                var str3=str2[1].split(".");
                            return InkWell(
                              onTap: (){
              
                              return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 400,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10,),
                                    Text(actividades[index].contenido,overflow: TextOverflow.ellipsis,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );
                              },
                              child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(175, 187, 172 , 1),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                              child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                children:[ 
                                  Text(str2[0]),
                                  SizedBox(height: 5.0),
                                  Row(
                                  children: [
                                    Icon(Icons.messenger),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                                ),
                                ]
                              ),
                          ),
                            ); 
                break;
                case 'Espacio':  var str=actividades[index].fecha;
                                 var str2=str.split(" ");
                                 var str3=str2[1].split(".");
                                return InkWell(
                                  
                                  onTap: (){
                                    var tokens=actividades[index].contenido.split(",");
                                    return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 600,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    ListTile(leading: Text("Nombre: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[0])),
                                    ListTile(leading: Text("Locacion: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),
                                    ListTile(leading: Text("Horario: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[2])),
                                    ListTile(leading: Text("Precio Hora: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[3])),
                    
                                    
                                    
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );

                                  },
                                  child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(245, 196, 76 , 1),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                              ],
                            ),
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                            child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children:[ 
                                  Text(str2[0]),
                                  SizedBox(height: 5.0),
                                   Row(
                                  children: [
                                    Icon(Icons.place),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                              ),
                              ]
                            ),
                          ),
                      ); 
                break;
                case "Photo":var str=actividades[index].fecha;
                              var str2=str.split(" ");
                              var str3=str2[1].split(".");
                            return InkWell(
                              onTap: (){
                                var tokens=actividades[index].contenido.split(",");
                             return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 500,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    ListTile(leading: Text("Nombre: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[0])),
                                    ListTile(leading: Text("Tipo: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),
                                    ListTile(leading: Text("Valor: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[2])),          
                                    
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );
                              },
                              child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(135, 202, 118  , 1),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                              child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[ 
                                  Text(str2[0]),
                                  SizedBox(height: 5.0),
                                  Row(
                                  children: [
                                    Icon(Icons.mic_external_on),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                                ),
                                ]
                              ),
                          ),
                            ); 

                break;
                case "Guion":
                var str=actividades[index].fecha;
                              var str2=str.split(" ");
                              var str3=str2[1].split(".");
                            return InkWell(
                              onTap: (){
                                var tokens=actividades[index].contenido.split(",");
                             return showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                  height: 600,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/homeback2.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                                 
                                  child: Column(children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(actividades[index].photoUrl),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Descripción: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold),), 
                                    SizedBox(height: 10,),
                                    Text(actividades[index].descripcion,textAlign: TextAlign.center,),
                                    SizedBox(height: 10,),
                                    ListTile(leading: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(str2[0])),
                                    ListTile(leading: Text("Hora: ",style: TextStyle(fontWeight: FontWeight.bold)),trailing:Text(str3[0],)), 
                                    SizedBox(height: 10,),
                                    Text("Contenido: ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.bold)),
                                    ListTile(leading: Text("Titulo: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[0])),
                                    ListTile(leading: Text("Tema: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),
                                    ListTile(leading: Text("Valor: ",style: TextStyle(fontWeight: FontWeight.bold),),trailing: Text(tokens[1])),          
                                    
                                  ],
                                  ),
                                  
                                ),
                              );},
                                
                              );
                              },
                              child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(135, 202, 118  , 1),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                              child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[ 
                                  Text(str2[0]),
                                  SizedBox(height: 5.0),
                                  Row(
                                  children: [
                                    Icon(Icons.mic_external_on),
                                    
                                    Expanded(
                                      child: Text(actividades[index].descripcion,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic
                                      ),),
                                    )
                                  ],
                                ),
                                ]
                              ),
                          ),
                            ); 
                break;
          default: return Container();
        }
      
      }
    );

  }
}
