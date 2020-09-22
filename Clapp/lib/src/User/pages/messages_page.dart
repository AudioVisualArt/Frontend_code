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
    bool nw;
    ScreenArgument(this.user,this.model,this.nameuser,this.id2,this.nw);
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
              body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/img/background.jpg"),
                  fit: BoxFit.cover,
                )),
                child: FutureBuilder(
                  future:  chatProvider.cargarChats(usuario.id),        
                  builder: (BuildContext context, AsyncSnapshot<List<ChatModel>>  snapshot) {
                     if(snapshot.hasData){
                      
                      List<ChatModel> chats=snapshot.data;
                      chats=_ordenarChats(chats);
                      return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context,index){  
                          if(chats[index].mensajes.length!=0){
                            return _tarjetaMensaje(chats[index],context,usuario); 
                          }else{
                            return Container(
                              width: 0,
                              height: 0,
                            );
                          }                   
                      },
                      );
                    }
                    else{
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                  
                ),
              ),
            );
     
        
      }

  List<ChatModel> _ordenarChats(List<ChatModel> chats) {
    ChatModel c;
    DateTime fecha1;
    DateTime fecha2;
    for(int i=0;i<chats.length;i++){ 
      for(int j=0;j<chats.length-1;j++){
        if(chats[j].mensajes==null){
          chats.removeAt(j);
          j++;
        }else{
        fecha1 = DateTime.parse(chats[j].fecha);
        fecha2 = DateTime.parse(chats[j+1].fecha);
        if(fecha2.isAfter(fecha1)){
          c=chats[j];
          chats[j]=chats[j+1];
          chats[j+1]=c;
        }
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
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.only(left:10.0, top: 5.0,right: 10.0),
      child: Stack(
        children:[
          
          Container(
            height: 83,
            child: Card(
            margin: EdgeInsets.only(top: 20.0,left: 30.0),
            color: Color.fromRGBO(246,246,246,1),
            elevation: 10.0,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
            child:ListTile(
                  leading: SizedBox(width: 10),
                title: Text("$username",style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.left,),
                subtitle: Text("$mens",style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis),
                onTap: (){
                  Navigator.pushNamed(context, 'messageInfo',arguments: ScreenArgument(
                          usuario,
                          e,
                          username,
                          idaux,
                          null
                  ));
                },
              ),

         
        ),
          ),
        Container(
          margin: EdgeInsets.only(top:10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40.0),                   
            child: FadeInImage(
                    image: NetworkImage(url),
                    placeholder: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png'),
                    height: 80.0,
                    width: 80.0,
                    fit: BoxFit.fill,
                  ),
            ),
        ),
        ]
      )
    );
    
  
  }
