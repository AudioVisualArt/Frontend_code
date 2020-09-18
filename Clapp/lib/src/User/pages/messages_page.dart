import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
class MensajePrueba{
  int id;
  NetworkImage img;
  String nombre;
  String asunto;
  String contenido;

  MensajePrueba(int id, String nombre,String asunto,String cont ){
    this.id=id;
    this.img=NetworkImage('https://pickaface.net/gallery/avatar/unr_prueba_180322_2201_36rfx.png');
    this.nombre=nombre;
    this.asunto=asunto;
    this.contenido=cont;
    
  }
}
class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MensajePrueba> mensajes=new List();
  @override
  Widget build(BuildContext context) {
    mensajes.clear();
    MensajePrueba msj=MensajePrueba(1,"Julio Diaz","informacion proyecto","Me comunico para pedir informacion acerca del nuevo proyecto que esta realizando");
    MensajePrueba msj2=MensajePrueba(2,"Carlos Peña","Aclaracion lugar de grabacion","Hola, no encuentro la direccion que me enviaron en google maps para llegar al rodaje, me puede confirmar al direccion? gracias"); 
    mensajes.add(msj);
    msj2.img=NetworkImage('https://pickaface.net/gallery/avatar/29586148_170117_1910_2p3e16n.png');
    mensajes.add(msj2); 
    //usuario=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mensajes',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
      body: ListView.builder(
        itemCount: mensajes.length,
        itemBuilder: (context,index){      
            return _tarjetaMensaje(mensajes[index],context);   
        },
        
      ),
    );
  }

  Widget _tarjetaMensaje(MensajePrueba e,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(10.0)
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left:20.0, top: 20.0,right: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: e.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: e.img,
                    placeholder: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png'),
                    height: 160.0,
                    width: 100.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ), 
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                    children: [
                      Text("${e.nombre}",style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 10.0),
                      Text("${e.asunto}",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,)
                    ],
                  ),
              ),
              
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(width: 60.0),
              RaisedButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(10.0),
                color: Colors.grey,
                child: Text('ABRIR'),
                onPressed: (){
                  Navigator.pushNamed(context, 'messageInfo',arguments: e);
                },
              ),
              SizedBox(width: 70.0),
              RaisedButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(10.0),
                color: Colors.redAccent,
                child: Text('BORRAR'),
                onPressed: (){
                },
              ),
            ],
          )
        ],
      )
    );
  }
}
