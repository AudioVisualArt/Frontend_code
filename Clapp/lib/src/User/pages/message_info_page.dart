import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:flutter/material.dart';

class MessageInfo extends StatefulWidget {
  MessageInfo({Key key}) : super(key: key);

    @override
  _MessageInfoState createState() => _MessageInfoState();
}

class _MessageInfoState extends State<MessageInfo> {
  final tarjetas=new List<Card>();
  @override
  Widget build(BuildContext context) {
  
   MensajePrueba msj=ModalRoute.of(context).settings.arguments;
   return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mensajes',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
      body: _mensajeInfo(msj,context),
      bottomSheet: _bottom(context),
        
      );
  }

  Widget _mensajeInfo(MensajePrueba msj,BuildContext context) {
    return Column(
      
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Center(
            child: Hero(
              tag: msj.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image:msj.img,
                  placeholder: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png'),
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ),
          ),
        ),
        Text(msj.nombre,style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center),
        _mensajes(msj,context),
        
      ],
    );
  }

  Widget _mensajes(MensajePrueba msj,BuildContext context) {
    if(tarjetas.length==0){
      Card aux=crearCard(msj.contenido, context);
      tarjetas.add(aux);
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: tarjetas.length,
      itemBuilder: (context,index){    
        return tarjetas[index];  
      });
  }

  Widget _bottom(BuildContext context) {
    String valor;
    return Container(
          margin: EdgeInsets.all(10.0),
          child: TextField(
        //autofocus: true,
        onChanged: (text){
          valor=text;
        },
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          labelText: 'Escriba su mensaje',
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: (){          
              Card aux=crearCardContact(valor, context);
              tarjetas.add(aux);
              setState(() {
                
              });
            },
          ),
          icon: Icon(Icons.account_circle)
        ),
  
      ),
    );
  }
  Widget crearCardContact(String msj,BuildContext context){
    return Card(
      margin: EdgeInsets.only(top: 10.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            trailing: Icon(Icons.message,color: Colors.green),
            title: Text(msj),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 70.0),
              Text('Ayer 20:00',style: Theme.of(context).textTheme.subtitle2)
            ],
          )
        ],
      ),
    );
  }
  Widget crearCard(String msj,BuildContext context){
    return Card(
      margin: EdgeInsets.only(top: 10.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.message,color: Colors.green),
            title: Text(msj),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 70.0),
              Text('Ayer 20:00',style: Theme.of(context).textTheme.subtitle2)
            ],
          )
        ],
      ),
    );
  }
}