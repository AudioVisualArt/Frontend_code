import 'package:Clapp/src/ScreenPlay/Pages/showPDF.dart';
import 'package:Clapp/src/ScreenPlay/Provider/screenplay_provider.dart';
import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/User/models/user_model.dart';

class ShowScreenPlayPage extends StatefulWidget {
  final List<ScreenPlayModel> screenPlays;
  final UserModel userModel;
  ShowScreenPlayPage(
      {List<ScreenPlayModel> this.screenPlays,
      UserModel this.userModel,
      Key key})
      : super(key: key);

  @override
  _ShowScreenPlayPageState createState() => _ShowScreenPlayPageState();
}

class _ShowScreenPlayPageState extends State<ShowScreenPlayPage> {
  final screenPlayProvider = ScreenPlayProvider();
  UserModel owner;
  UsuarioProvider user = UsuarioProvider();
  ChatProvider chat = ChatProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guiones',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostrarItems2.jpeg"),
          fit: BoxFit.cover,
        )),
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Flexible(flex: 1, child: _crearListadoScreenPlays()),
            ],
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _crearListadoScreenPlays() {
    return FutureBuilder(
      future: screenPlayProvider
          .cargarScreenPlaysNotSessionUser(widget.userModel.id),
      builder: (BuildContext context,
          AsyncSnapshot<List<ScreenPlayModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20.0,
                );
              },
              itemCount: equipos.length,
              itemBuilder: (context, index) {
                return _tarjetaScreenPlay(context, equipos[index]);
              });
        } else {
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(0, 51, 51, 1.0),
            )),
          );
        }
      },
    );
  }

  Widget _tarjetaScreenPlay(
      BuildContext context, ScreenPlayModel screenPlayModel) {
    final _containerInfoUser = Container(
      height: 140.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white70,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    '    Por:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                ),
                _obtenerNombre(context, screenPlayModel.idOwner) ??
                    " Not User ",
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    '    Paginas:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    screenPlayModel.pages.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    '    Precio:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    screenPlayModel.valor.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    '    Temática:',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    screenPlayModel.topic,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );

    final _containerInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 8.0,
        ),
        Text(
          screenPlayModel.titulo ?? "",
          style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          screenPlayModel.itemDescription ?? " ",
          style: TextStyle(fontSize: 10.0, fontFamily: "Raleway"),
        ),
        SizedBox(
          height: 20.0,
        ),
        _containerInfoUser,
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: 115.0,
                child: RaisedButton.icon(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color.fromRGBO(112, 252, 118, 1.0),
                    label: Text(
                      'Ver ',
                      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
                      textAlign: TextAlign.center,
                    ),
                    autofocus: true,
                    icon: Icon(
                      Icons.description,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ShowPDF(
                                    screenPlayModel: screenPlayModel,
                                  )));
                    }),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                child: RaisedButton.icon(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color.fromRGBO(112, 252, 118, 1.0),
                    label: Text(
                      'Contactar',
                      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
                      textAlign: TextAlign.center,
                    ),
                    autofocus: true,
                    icon: Icon(
                      Icons.mark_chat_read,
                    ),
                    onPressed: () async {
                      if (widget.userModel.id != screenPlayModel.idOwner) {
                        ChatModel chat = await _conseguirChat(
                            screenPlayModel.idOwner, widget.userModel);
                        ScreenArgument sc = ScreenArgument(
                            widget.userModel, chat, owner.name, owner.id, null);
                        Navigator.pushNamed(context, 'messageInfo',
                            arguments: sc);
                      }
                    }),
              ),
            ),
          ],
        ),
      ],
    );

    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromRGBO(227, 227, 227, 1.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black45,
                spreadRadius: 1.0,
                blurRadius: 5.0,
                offset: Offset(2.0, 5.0))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: _containerInfo,
            ),
          ],
        ),
      ),
      elevation: 4.0,
      color: Color.fromRGBO(227, 227, 227, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }

  Widget _obtenerNombre(BuildContext context, String id) {
    final usuarioProvider = UsuarioProvider();

    return FutureBuilder(
        future: usuarioProvider.obtenerUsuario(id),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            return Text(
              '    ' + snapshot.data.name,
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Raleway",
              ),
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        });
  }

  Future<ChatModel> _conseguirChat(String tag, UserModel usuarioOferta) async {
    owner = await user.obtenerUsuario(tag);
    bool existe = false;
    ChatModel ct;
    List<ChatModel> chats = await chat.cargarChats(usuarioOferta.id);
    if (chats != null) {
      chats.forEach((element) {
        if (element.usuarioD == usuarioOferta.id || element.usuarioD == tag) {
          if (element.usuarioO == usuarioOferta.id || element.usuarioO == tag) {
            existe = true;
            ct = element;
          }
        }
      });
    }

    if (existe == false) {
      ct = ChatModel(
          chatId: "dddd",
          fecha: DateTime.now().toString(),
          nameD: owner.name,
          nameO: usuarioOferta.name,
          photoUrlD: owner.photoUrl,
          photoUrlO: usuarioOferta.photoUrl,
          usuarioD: tag,
          usuarioO: usuarioOferta.id);
      bool resp = await chat.crearChat(ct);
      chats = await chat.cargarChats(usuarioOferta.id);
      chats.forEach((element) {
        if (element.usuarioD == usuarioOferta.id || element.usuarioD == tag) {
          if (element.usuarioO == usuarioOferta.id || element.usuarioO == tag) {
            ct = element;
          }
        }
      });
    }
    return ct;
  }
}
