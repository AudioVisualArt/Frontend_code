import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/mensaje_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:flutter/material.dart';

class MessageInfo extends StatefulWidget {
  MessageInfo({Key key}) : super(key: key);

    @override
  _MessageInfoState createState() => _MessageInfoState();
}

class _MessageInfoState extends State<MessageInfo> {
  ChatProvider chatProvider=new ChatProvider();
  ActividadProvider actividadProvider=new ActividadProvider();
  ChatModel aux;
  bool cambio=false;
  ScreenArgument args;
  final tarjetas=new List<Widget>();
  @override
  Widget build(BuildContext context) {
   
   args=ModalRoute.of(context).settings.arguments;
   int contador=0;
   if(cambio==true){
     args.model=aux;
   }
   if(args.model.mensajes.length!=0 && args.model.mensajes.length!=null){
     args.model.mensajes=_ordenarMensajes(args.model.mensajes);
     contador=args.model.mensajes[args.model.mensajes.length-1].cont;
   }

   args.nw=true;
   return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mensajes',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
      body: _mensajeInfo(args.model,context,args.user,args.nameuser),
      bottomSheet: _bottom(context,args.user,args.model.chatId,args.id2,contador),
        
      );
  }

  Widget _mensajeInfo(ChatModel chat,BuildContext context, UserModel user,String name) {
    String url;
      if(chat.usuarioD==user.id){
        print(url);
        url=chat.photoUrlO;
      }else{
        print(url);
        url=chat.photoUrlD;
      }
    return Wrap(
          children: [Column(
        
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Hero(
                tag: user.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35.0),
                  child: FadeInImage(
                    image: NetworkImage(url),
                    placeholder: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png'),
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Text(name,style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center),
          _mensajes(chat,context,user),
          
        ],
      ),
          ]
    );
  }

  Widget _mensajes(ChatModel chat,BuildContext context,UserModel user) {
    tarjetas.clear();
    int i=0;
    if(chat.mensajes==null){
      return Container(

      );
    }
    chat.mensajes.forEach((element) {
       if(element.usuario==user.name){
        tarjetas.add(crearCardContact(element, context));
      }else{
        tarjetas.add(crearCard(element, context));
      }

    });

   
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: tarjetas.length,
      itemBuilder: (context,index){    
        return tarjetas[index];  
      });
  }

  Widget _bottom(BuildContext context,UserModel usuario,String id,String idUser2,int ct) {
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
            onPressed: () async {     
              MensajeModel nuevoMsj= await _crearMensaje(valor,usuario,id,idUser2,ct);  

              setState(() {
                
              }); 
            },
          ),
          icon: Icon(Icons.account_circle)
        ),
  
      ),
    );
  }
  Widget crearCardContact(MensajeModel msj,BuildContext context){
    return Card(
      color: Color.fromRGBO(169, 196, 230, 0.5),
      margin: EdgeInsets.only(top: 10.0,left: 35.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            
            title: SizedBox(width: 15.0,child: Text(msj.contenido)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 30.0),
              Text(msj.fecha,style: Theme.of(context).textTheme.subtitle2)
            ],
          )
        ],
      ),
    );
  }
  Widget crearCard(MensajeModel msj,BuildContext context){
    return Card(
    
      margin: EdgeInsets.only(top: 10.0,right: 35.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            
            title: Text(msj.contenido),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 70.0),
              Text(msj.fecha,style: Theme.of(context).textTheme.subtitle2)
            ],
          )
        ],
      ),
    );
  }

  Future<MensajeModel> _crearMensaje(String valor, UserModel usuario,String id,String iduser2, int ct) async {
   
    var now = new DateTime.now();
    String fecha=now.toString();
    int cont2=ct+1;
    MensajeModel nuevoM=MensajeModel(
      chatid: id,
      contenido: valor,
      usuario: usuario.name,
      fecha: fecha,
      cont: cont2

    );
    bool confi= await chatProvider.crearMensaje(nuevoM,fecha);
     List<ChatModel> chats=await chatProvider.cargarChats(usuario.id);
     chats.forEach((element) {
       if(element.usuarioD==iduser2 || element.usuarioO==iduser2){
         if(element.usuarioD==usuario.id || element.usuarioO==usuario.id){
           aux=element;
           cambio=true;
         }
       }
     });
    ActividadModel activity=new ActividadModel(
      descripcion: "Enviaste enviado un mensaje a ${args.nameuser}",
      fecha: DateTime.now().toString(),
      tipo: "Mensaje"

    );
    actividadProvider.crearActividad(activity, usuario.id);
    return nuevoM;
  }

  List<MensajeModel> _ordenarMensajes(List<MensajeModel> mensajes) {
    if(mensajes.length==0 || mensajes.length==null){
      return null;
    }
    mensajes.sort((a,b)=>a.cont.compareTo(b.cont));
    return mensajes;
  }

}