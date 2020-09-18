import 'dart:convert';

import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
class ScreenArgument{
    UserModel user;
    ChatModel model;
    String nameuser;
    String id2;
    ScreenArgument(this.user,this.model,this.nameuser,this.id2);
}

class MessagePage extends StatelessWidget {
  
  final chatProvider=new ChatProvider();
  final List<String> mensajes=new List();
  @override
  Widget build(BuildContext context) {

    UserModel usuario=ModalRoute.of(context).settings.arguments;
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Mensajes',
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
                ),
              ),
              body: FutureBuilder(
                future:  chatProvider.cargarChats(usuario.id),        
                builder: (BuildContext context, AsyncSnapshot<List<ChatModel>>  snapshot) {
                   if(snapshot.hasData){
                    
                    List<ChatModel> chats=snapshot.data;
                    chats=_ordenarChats(chats);
                    return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context,index){  
                  
                        return _tarjetaMensaje(chats[index],context,usuario);  
                    
                    },
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
                
              ),
            );
     
        
      }

  List<ChatModel> _ordenarChats(List<ChatModel> chats) {
    ChatModel c;
    DateTime fecha1;
    DateTime fecha2;
    for(int i=0;i<chats.length;i++){ 
      for(int j=0;j<chats.length-1;j++){
        fecha1 = DateTime.parse(chats[j].fecha);
        fecha2 = DateTime.parse(chats[j+1].fecha);
        if(fecha2.isAfter(fecha1)){
          c=chats[j];
          chats[j]=chats[j+1];
          chats[j+1]=c;
        }
      }
    }
    return chats;
  }
    
  }

  Widget _tarjetaMensaje(ChatModel e,BuildContext context,UserModel usuario) {
      String url,idaux,username,mens;
      
      if(e.usuarioD==usuario.id){
        url=e.photoUrlO;
        idaux=e.usuarioO;
        username=e.nameO;
      }else{
        url=e.photoUrlD;
        idaux=e.usuarioD;
        username=e.nameD;
      }
      e.mensajes.sort((a,b)=>a.cont.compareTo(b.cont));
      final mensaje=e.mensajes[e.mensajes.length-1];
      if(mensaje.usuario==usuario.name){
        mens="Tu: ${mensaje.contenido}";
      }else{
        mens=mensaje.contenido;
      }
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
                tag: e.chatId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage(url),
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
                      Text("$username",style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 10.0),
                      Text("$mens",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
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

                    Navigator.pushNamed(context, 'messageInfo',arguments: ScreenArgument(
                    usuario,
                    e,
                    mensaje.usuario,
                    idaux
                  ));
                  setState(){

                  }               
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
