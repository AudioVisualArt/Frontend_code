import 'dart:io';

import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/StockPhoto/provider/stockphoto_provider.dart';
import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class StockPhotoComprarPage extends StatefulWidget {
  final UserModel userModel;
  final StockPhotoModel stockPhotoModel;
  StockPhotoComprarPage({Key key, this.stockPhotoModel, this.userModel})
      : super(key: key);

  @override
  _StockPhotoComprarPageState createState() => _StockPhotoComprarPageState();
}

class _StockPhotoComprarPageState extends State<StockPhotoComprarPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final stockPhotoProvider = new StockPhotoProvider();
  UserModel owner;
  bool _guardando = false;
  UsuarioProvider userProvider=UsuarioProvider();
  bool _equipo = false;
  ChatProvider chat=ChatProvider();
  File foto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Equipo',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  Divider(),
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearPhotoType(),
                  Divider(),
                  _crearWidth(),
                  Divider(),
                  _crearHeight(),
                  Divider(),
                  _crearPrecio(),
                  Divider(),
                  _crearBoton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.stockPhotoModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.stockPhotoModel.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: widget.stockPhotoModel.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearPhotoType() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.stockPhotoModel.photoType,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearWidth() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.stockPhotoModel.width.toString(),
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearHeight() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.stockPhotoModel.height.toString() ?? " ",
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),
      textColor: Colors.white,
      label: Text(
        'Contactar',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      icon: Icon(Icons.system_update_alt),
      onPressed: () async {

                      if (widget.userModel.id != widget.stockPhotoModel.idOwner) {
                        ChatModel chat = await _conseguirChat(
                            widget.stockPhotoModel.idOwner, widget.userModel);
                        ScreenArgument sc = ScreenArgument(
                           widget.userModel, chat, owner.name, owner.id, null);
                        Navigator.pushNamed(context, 'messageInfo',
                            arguments: sc);
                      }
      
      },
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print('Todo Ok');

    setState(() {
      _guardando = true;
    });

    widget.stockPhotoModel.idOwner = widget.userModel.id;
    widget.stockPhotoModel.disponible = false;

    stockPhotoProvider.editarPhoto(widget.stockPhotoModel, foto);

    utils.mostrarAlerta(context, 'Compra Realizada');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snacckbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 3),
    );

    scaffoldKey.currentState.showSnackBar(snacckbar);
  }

  Widget _mostrarFoto() {
    print('FotoURL: ' + widget.stockPhotoModel.fotoUrl);
    if (widget.stockPhotoModel.fotoUrl.isEmpty ||
        widget.stockPhotoModel.fotoUrl == null) {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else if (widget.stockPhotoModel.fotoUrl != null ||
        widget.stockPhotoModel.fotoUrl.isNotEmpty) {
      if (foto != null) {
        return Image(
          image: AssetImage(foto.path),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          image: NetworkImage(widget.stockPhotoModel.fotoUrl),
        );
      }
    }
  }
   Future<ChatModel> _conseguirChat(
      String tag, UserModel usuarioOferta) async {
     owner=await userProvider.obtenerUsuario(tag);
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
