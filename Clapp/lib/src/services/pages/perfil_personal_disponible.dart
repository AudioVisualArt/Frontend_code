import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/services/pages/send_contract_page.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';

import 'curriculum_page.dart';

class PerfilPersonal extends StatelessWidget {
  String tag, rol;
  String name, description, ciudad, profesion, photoUrl, hvUrl;
  UserModel usuarioOferta;
  //final description;
  PerfilPersonal(this.tag,
      this.rol,
      this.name, this.description, this.profesion, this.ciudad, this.photoUrl, this.usuarioOferta, this.hvUrl);
  ChatProvider chat=new ChatProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    print('URL DE LA PHOTO ${this.photoUrl}');
    if(this.photoUrl==null){
      this.photoUrl="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png";
    }
    var assetpath = "assets/img/perfiltest.PNG";
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil',
              style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          //backgroundColor: Colors.white70,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          )),




              child: ListView(
                children: [
                 Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only (top: 20),
                  child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(227, 227, 227, 1),),
                          margin: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0
                          ),
                          padding: EdgeInsets.only(
                            left: 7.0,
                            right: 10.0,

                          ),

                          height: 190,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 30.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 7.0),
                                child:
                                Hero(
                                  //tag: worker.userId,
                                  tag: tag,
                                  child: Container(
                                      height: 150.0,
                                      width: 150.0,
                                      child: _constructorImagen()),
                                ),),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: EdgeInsets.only(top: 30.0, left: 35.0),
                                    child: Text(name,
                                      style: TextStyle(fontSize: 18.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),),
                                  ),
                                  SizedBox(height: 7.0,),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 35.0
                                    ),
                                    child: Text(rol,
                                      style: TextStyle(fontSize: 18.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                                    ),

                                  ),
                                  SizedBox(height: 20.0,),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 35.0
                                    ),
                                    child: Text(profesion,
                                      style: TextStyle(fontSize: 18.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                                    ),

                                  ),
                                  SizedBox(height: 7.0,),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 35.0
                                    ),
                                    child: Text(ciudad,
                                      style: TextStyle(fontSize: 18.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                                    ),

                                  ),



                                ],
                              )
                            ],
                          )),
                      ),

                      SizedBox(height: 20.0),
                      SizedBox(child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(227, 227, 227, 1),),
                        height: 100,
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
                        child: Text(description,
                          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),

                        ),


                      ),
                      ),

                      SizedBox(height: 20.0),
                     Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 110.0, right: 7.0, left: 7.0),
                                    child: RaisedButton(
                                      padding:
                                      EdgeInsets.only(top: 13, bottom: 13, left: 52, right: 51),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Text('Estudio',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: "Raleway",
                                              color: Color.fromRGBO(115, 115, 115, 1.0),
                                              fontWeight: FontWeight.bold)),
                                      textColor: Colors.white,
                                      color: Color.fromRGBO(227, 227, 227, 1),
                                      onPressed: (){

                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10.0, right: 7.0, left: 7.0),
                                    child: RaisedButton(
                                      padding:
                                      EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Text('Mandar Contrato',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: "Raleway",
                                              color: Color.fromRGBO(115, 115, 115, 1.0),
                                              fontWeight: FontWeight.bold)),
                                      textColor: Colors.white,
                                      color: Color.fromRGBO(227, 227, 227, 1),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context)=> SendContract(tag, usuarioOferta)));
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 110.0, right: 7.0, left: 7.0),
                                    child: RaisedButton(
                                      padding:
                                      EdgeInsets.only(top: 13, bottom: 13, left: 40, right: 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Text('Contactar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: "Raleway",
                                              color: Color.fromRGBO(115, 115, 115, 1.0),
                                              fontWeight: FontWeight.bold)),
                                      textColor: Colors.white,
                                      color: Color.fromRGBO(227, 227, 227, 1),
                                      onPressed: ()async{
                                        if(tag!=usuarioOferta.id){
                                           ChatModel chat=await _conseguirChat(tag,name,photoUrl,usuarioOferta);
                                          ScreenArgument sc=ScreenArgument(usuarioOferta, chat, name, tag,null);
                                          Navigator.pushNamed(context, 'messageInfo',arguments: sc);
                                        }
                                        
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10.0, right: 7.0, left: 7.0),
                                    child: RaisedButton(
                                      padding:
                                      EdgeInsets.only(top: 13, bottom: 13, left: 40, right: 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Text('Portafolio',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: "Raleway",
                                              color: Color.fromRGBO(115, 115, 115, 1.0),
                                              fontWeight: FontWeight.bold)),
                                      textColor: Colors.white,
                                      color: Color.fromRGBO(227, 227, 227, 1),
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HVPage(
                                                workerHv:hvUrl
                                              )),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),

                            ],
                          )
                      ),



                    ],
                  )
                ],
              )



        ));
  }

  Widget _constructorImagen() {

    if (photoUrl == null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100.0),

          child: CircleAvatar(

              radius: 75,
              child: Image(
                image: AssetImage('assets/img/no-image.png'),
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              )
          )

      );
    } else if (photoUrl != null || photoUrl.isNotEmpty) {
      return Container(
          height: 150.0,
          width: 150.0,
          child: CircleAvatar(
              radius: 100,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(

                radius: 100,
                backgroundImage: NetworkImage(
                  photoUrl,

                ),


              )
          )
      );
    }


  }

  Future<ChatModel> _conseguirChat(String tag,String name,String photo, UserModel usuarioOferta) async {
    bool existe=false;
    ChatModel ct;
    List<ChatModel> chats=await chat.cargarChats(usuarioOferta.id);
    if(chats!=null){
      chats.forEach((element) {
        if(element.usuarioD==usuarioOferta.id || element.usuarioD==tag){
          if(element.usuarioO==usuarioOferta.id || element.usuarioO==tag){
            existe=true;
            ct=element;
          }
        }
      });
    }

    if(existe==false){

      ct=ChatModel(
        chatId: "dddd",
        fecha: DateTime.now().toString(),
        nameD: name,
        nameO: usuarioOferta.name,
        photoUrlD: photo,
        photoUrlO: usuarioOferta.photoUrl,
        usuarioD: tag,
        usuarioO: usuarioOferta.id
      );
      bool resp=await chat.crearChat(ct);
      chats= await chat.cargarChats(usuarioOferta.id);
      chats.forEach((element) {
        if(element.usuarioD==usuarioOferta.id || element.usuarioD==tag){
          if(element.usuarioO==usuarioOferta.id || element.usuarioO==tag){
            ct=element;
          }
        }
      });
    }
    return ct;
  }
}
