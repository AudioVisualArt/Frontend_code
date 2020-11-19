import 'dart:io';

import 'package:Clapp/src/Props/Model/prop_model.dart';
import 'package:Clapp/src/Props/Provider/prop_provider.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart';
import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class PropBuyPage extends StatefulWidget {
  UserModel userModel;
  PropModel propModel;
  PropBuyPage({this.userModel, this.propModel});

  @override
  _PropBuyPageState createState() => _PropBuyPageState();
}

class _PropBuyPageState extends State<PropBuyPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  UserModel owner;
  PropModel propModel = new PropModel();
  final propProvider = new PropProvider();
  UsuarioProvider usuarioProvider=UsuarioProvider();
  bool _guardando = false;
  bool _loading = false;
  File foto;
  ChatProvider chat=ChatProvider();
  ChatModel chatU;
  @override
  Widget build(BuildContext context) {
    widget.userModel = ModalRoute.of(context).settings.arguments;
  /*   if (widget.userModel.id != widget.propModel.idOwner) {
          _conseguirChat(
              widget.propModel.idOwner, widget.userModel);
        } */
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
            'Prop',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _mostrarFoto(),
                  Divider(),
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearPropType(),
                  Divider(),
                  _crearPropTheme(),
                  Divider(),
                  _crearPrecio(),
                  Divider(),
                  _crearBoton(),
                  Divider(),
                  _loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(0, 51, 51, 1.0),
                        ))
                      : Container(
                          height: 0.0,
                          width: 0.0,
                        ),
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
      initialValue: propModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre de tu Foto',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: propModel.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción Simple',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: propModel.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearPropType() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: propModel.propType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Tipo?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearPropTheme() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: propModel.propType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Tema?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
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
      icon: Icon(Icons.message),
      onPressed: () async {
        /* if (widget.userModel.id != widget.propModel.idOwner && chatU!=null) {
        
          ScreenArgument sc = ScreenArgument(
              widget.userModel, chatU, owner.name, owner.id, null);
          Navigator.pushNamed(context, 'messageInfo', arguments: sc);
        } */
      },
    );
  }

  Widget _mostrarFoto() {
    print('FotoURL: ' + widget.propModel.fotoUrl);
    if (propModel.fotoUrl.isEmpty || widget.propModel.fotoUrl == null) {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else if (widget.propModel.fotoUrl != null ||
        widget.propModel.fotoUrl.isNotEmpty) {
      if (foto != null) {
        return Image(
          image: AssetImage(foto.path),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          image: NetworkImage(widget.propModel.fotoUrl),
        );
      }
    }
  }
  /* void _conseguirChat(String tag, UserModel usuarioOferta) async {
    owner = await usuarioProvider.obtenerUsuario(tag);
    bool existe = false;
    
    ChatModel ct = await chat.cargarChat(usuarioOferta.id,tag);
   

    if (ct == null) {
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
       ct = await chat.cargarChat(usuarioOferta.id,tag);
    }
    chatU=ct;
  } */
}
