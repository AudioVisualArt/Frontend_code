import 'dart:io';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/messages_page.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class EquipmentCompraPage extends StatefulWidget {
  final UserModel userModel;
  final EquipmentModel equipmentModel;
  
  EquipmentCompraPage({Key key, this.userModel, this.equipmentModel})
      : super(key: key);

  @override
  _EquipmentCompraPageState createState() => _EquipmentCompraPageState();
}

class _EquipmentCompraPageState extends State<EquipmentCompraPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  ChatProvider chat = new ChatProvider();
  final equipmentProvider = new EquipmentProvider();
  UsuarioProvider userProvider=UsuarioProvider();
  UserModel owner;
  bool _guardando = false;

  bool _equipo = false;

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
                  Hero(
                    tag: widget.equipmentModel.id,
                    child: _mostrarFoto(),
                  ),
                  Divider(),
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearSpecs(),
                  Divider(),
                  _crearMarca(),
                  Divider(),
                  _crearModelo(),
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
      initialValue: widget.equipmentModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.equipmentModel.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: widget.equipmentModel.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearSpecs() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.equipmentModel.specs,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearMarca() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.equipmentModel.marca,
      textCapitalization: TextCapitalization.sentences,
      enabled: false,
      enableInteractiveSelection: false,
    );
  }

  Widget _crearModelo() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: widget.equipmentModel.modelo,
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

                      if (widget.userModel.id != widget.equipmentModel.idOwner) {
                        ChatModel chat = await _conseguirChat(
                            widget.equipmentModel.idOwner, widget.userModel);
                        ScreenArgument sc = ScreenArgument(
                           widget.userModel, chat, owner.name, owner.id, null);
                        Navigator.pushNamed(context, 'messageInfo',
                            arguments: sc);
                      }
      
      },
    );
  }

  //Función para mensajes
  void _submit() {
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
    print('FotoURL: ' + widget.equipmentModel.fotoUrl);
    if (widget.equipmentModel.fotoUrl.isEmpty ||
        widget.equipmentModel.fotoUrl == null) {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else if (widget.equipmentModel.fotoUrl != null ||
        widget.equipmentModel.fotoUrl.isNotEmpty) {
      if (foto != null) {
        return Image(
          image: AssetImage(foto.path),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return FadeInImage(
          placeholder: AssetImage('assets/img/loader3.gif'),
          image: NetworkImage(widget.equipmentModel.fotoUrl),
        );
      }
    }
  }

  _seleccionarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (foto != null) {
      //limpiar

    }
    setState(() {});
  }

  _tomarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.camera);

    if (foto == null) {
      //limpiar
      setState(() {});
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
