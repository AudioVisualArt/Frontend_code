import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:clay_containers/clay_containers.dart';

import 'new_space.dart';

final List<String> imgList = [
  'assets/img/space1.JPG',
  'assets/img/espacios.PNG',
];

class SpaceDetails extends StatefulWidget {
  final SegPagina arg;
  SpaceDetails({Key key, this.arg}) : super(key: key);
  //final UserModel userF;

  //SpaceDetails({Key key,this.userF}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SpaceDetails();
  }
}

class _SpaceDetails extends State<SpaceDetails> {
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  WorkersProvider workersProvider = new WorkersProvider();
  ChatProvider chat = new ChatProvider();
  List<dynamic> arg = new List();
  UserModel usuario;
  @override
  Widget build(BuildContext context) {
    SegPagina usrSpace = ModalRoute.of(context).settings.arguments;

    //arg= ModalRoute.of(context).settings.arguments;

    SpaceModel espacio = usrSpace.space2;
    usuario = usrSpace.usuario2;
    //SpaceModel espacio =arg[1];
    //usuario=arg[0];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 30,
          width: double.infinity,
          /*decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          )),

           */
          child: ListView(
            children: [
              _listimages(espacio),
              infospace(
                  'Horario',
                  //espacio.scheduleDays,
                  "Lunes a viernes",
                  espacio.scheduleHours),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                          constraints: BoxConstraints(
                              minWidth:
                                  MediaQuery.of(context).size.width - 20.0,
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight: 260,
                              minHeight: 200),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(227, 227, 227, 1),
                          ),
                          padding: EdgeInsets.all(2),
                          child: Center(
                            child: ClayContainer(
                                borderRadius: 10,
                                curveType: CurveType.none,
                                color: Color.fromRGBO(227, 227, 227, 1),
                                depth: 30,
                                spread: 10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 12.0,
                                                left: 10.0,
                                                right: 5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  minWidth: 100,
                                                  maxWidth: 200,
                                                  maxHeight: 56,
                                                  minHeight: 22),
                                              child: Text(
                                                espacio.name,
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: "Raleway",
                                                    color: Color.fromRGBO(
                                                            115, 115, 115, 1.0)
                                                        .withOpacity(1),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 5, top: 12),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minWidth: 100,
                                                maxWidth: 200,
                                                maxHeight: 22,
                                              ),
                                              child: Text(
                                                espacio.location,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: "Raleway",
                                                  color: Color.fromRGBO(
                                                      115, 115, 115, 1.0),
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 12, left: 10, right: 12),
                                            child: SmoothStarRating(
                                              rating: 0,
                                              isReadOnly: false,
                                              size: 22,
                                              filledIconData: Icons.star,
                                              halfFilledIconData:
                                                  Icons.star_half,
                                              defaultIconData:
                                                  Icons.star_border,
                                              starCount: 5,
                                              allowHalfRating: true,
                                              spacing: 2.0,
                                              onRated: (value) {
                                                print("rating value -> $value");
                                              },
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 5, top: 8),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  minWidth: 100,
                                                  maxWidth: 200,
                                                  maxHeight: 110,
                                                  minHeight: 22),
                                              child: Text(espacio.description,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "Raleway",
                                                    color: Color.fromRGBO(
                                                        115, 115, 115, 1.0),
                                                  ),
                                                  textAlign: TextAlign.justify),
                                            )),
                                      ],
                                    ),
                                    _uderInfo(espacio)
                                  ],
                                )),
                          ))),
                  infospace('Tarifa', "${espacio.minimumHours} min",
                      '${espacio.priceHour} COP/hora'),
                ],
              )
            ],
          )),
    );
  }

  Widget infospace(String nombre, String der, String izq) {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
        child: Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 20.0,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: 100,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromRGBO(227, 227, 227, 1),
            ),
            padding: EdgeInsets.all(2),
            child: Center(
              child: ClayContainer(
                  color: Color.fromRGBO(227, 227, 227, 1),
                  borderRadius: 10,
                  curveType: CurveType.none,
                  depth: 30,
                  spread: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: 10.0, right: 15, top: 12),
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: 100,
                                maxWidth: 130,
                                maxHeight: 42,
                                minHeight: 22),
                            child: Text(
                              nombre,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(115, 115, 115, 1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 5, top: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 162,
                                    maxHeight: 42,
                                    minHeight: 22),
                                child: Text(
                                  der,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(115, 115, 115, 1.0),
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 15, top: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 180,
                                    maxHeight: 42,
                                    minHeight: 22),
                                child: Text(
                                  izq,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(115, 115, 115, 1.0),
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              )),
                        ],
                      )
                    ],
                  )),
            )));
  }

  Widget _listimages(SpaceModel espacio) {
    return Container(
        padding: EdgeInsets.only(left: 4, right: 4, top: 5),
        child: Center(
          child: ClayContainer(
              borderRadius: 10,
              curveType: CurveType.none,
              color: Color.fromRGBO(227, 227, 227, 1),
              depth: 40,
              spread: 10,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Card(
                    child: Hero(
                      tag: espacio.id,
                      child: Image(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        image: NetworkImage(espacio.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))),
        ));
  }

  _uderInfo(SpaceModel espacio) {
    final Future<UserModel> userModel =
        workersProvider.cargarUsuarioTrabajador(espacio.userOwner);
    return FutureBuilder<UserModel>(
        future: userModel,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            UserModel user = snapshot.data;
            return Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 32.0, left: 5, right: 15),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: _constructorImagen(user),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 7.0, right: 15, top: 4),
                    child: Container(
                      constraints: BoxConstraints(
                          minWidth: 100,
                          maxWidth: 145,
                          maxHeight: 42,
                          minHeight: 22),
                      child: Text(
                        user.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(115, 115, 115, 1.0),
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    right: 15.0,
                    left: 7.0,
                  ),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text('Contactar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Raleway",
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    textColor: Colors.white,
                    color: Color.fromRGBO(0, 51, 51, 0.8),
                    onPressed: () async {
                      if (user.id != usuario.id) {
                        ChatModel chat = await _conseguirChat(
                            user.id, user.name, user.photoUrl, usuario);
                        ScreenArgument sc = ScreenArgument(
                            usuario, chat, user.name, user.id, null);
                        Navigator.pushNamed(context, 'messageInfo',
                            arguments: sc);
                      }
                    },
                  ),
                )
              ],
            );
          }
        });
  }

  Future<ChatModel> _conseguirChat(
      String tag, String name, String photo, UserModel usuarioOferta) async {
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
          nameD: name,
          nameO: usuarioOferta.name,
          photoUrlD: photo,
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

  Widget _constructorImagen(UserModel user) {
    if (user.photoUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          width: 100.0,
          height: 100.0,
        ),
      );
    } else if (user.photoUrl != null || user.photoUrl.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                user.photoUrl,
              ),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover));
    }
  }
}
