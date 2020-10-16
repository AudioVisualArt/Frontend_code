import 'dart:io';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/bloc/signup_bloc.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/User/widgets/background_login.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  UserModel userModel;
  SignUp({Key key, this.userModel}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final usuarioProvider = new UsuarioProvider();
  File foto;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(text: "Registro"), _signUp(context)],
      ),
      appBar: AppBar(
        title: Text(
          'Registro',
          style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
    );
  }

  _seleccionarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //limpiar
    setState(() {
      foto = File(pickedFile.path);
    });
  }

  _tomarFoto() async {
    //foto = await ImagePicker.pickImage(source: ImageSource.camera);
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    //limpiar
    setState(() {
      foto = File(pickedFile.path);
    });
  }

  Widget _signUp(BuildContext context) {
    final bloc = Provider.ofSignUp(context);
    final size = MediaQuery.of(context).size;

    final container = Container(
      width: size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 40.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0),
          ]),
      child: Column(
        children: <Widget>[
          Text('Crear Cuenta',
              style: TextStyle(fontSize: 22.0, fontFamily: "Raleway")),
          SizedBox(height: 40.0),
          _mostrarFoto(bloc),
          SizedBox(height: 30.0),
          _registroEmail(bloc),
          SizedBox(height: 30.0),
          _registroNombre(bloc),
          SizedBox(height: 30.0),
          _registroAge(bloc),
          SizedBox(height: 30.0),
          _crearPassword(bloc),
          SizedBox(height: 30.0),
          _registroCity(bloc),
          SizedBox(height: 30.0),
          _registroDescription(bloc),
          SizedBox(height: 30.0),
          _crearBotonRegistro(bloc),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          container,
          SizedBox(height: 100.0),
        ],
      )),
    );
  }

  Widget _mostrarFoto(SignUpBloc bloc) {
    //print('FotoURL: ' + bloc.photo);

    if (foto != null) {
      return Image.file(
        File(foto.path),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else if (foto == null) {
      return FadeInImage(
        placeholder: AssetImage('assets/img/jar-loading.gif'),
        image: AssetImage('assets/img/no-image.png'),
      );
    }
  }

  Widget _registroCity(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.cityStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.location_on,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'Ingresa la ciudad en la que vives',
              labelText: 'Ciudad',
              labelStyle: TextStyle(fontSize: 17.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                  borderRadius: BorderRadius.circular(25.0)),
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeCity,
          ),
        );
      },
    );
  }

  Widget _registroAge(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.ageStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'Ingresa tu edad',
              labelStyle: TextStyle(fontSize: 17.0),
              labelText: 'Edad',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                  borderRadius: BorderRadius.circular(25.0)),
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeAge,
          ),
        );
      },
    );
  }

  Widget _registroDescription(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.descriptionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            maxLength: 125,
            decoration: InputDecoration(

              icon: Icon(Icons.text_fields,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'cuentanos de ti!',
              labelText: 'Descripcion',
              labelStyle: TextStyle(fontSize: 17.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                  borderRadius: BorderRadius.circular(25.0)),
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeDescription,
          ),
        );
      },
    );
  }

  Widget _registroEmail(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'ejemplo@dominio.com.co',
              labelText: 'Correo Electronico',
              labelStyle: TextStyle(fontSize: 17.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                  borderRadius: BorderRadius.circular(25.0)),
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _registroNombre(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.verified_user,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'Pepito Perez',
              labelText: 'Nombre completo',
              labelStyle: TextStyle(fontSize: 17.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                  borderRadius: BorderRadius.circular(25.0)),
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeName,
          ),
        );
      },
    );
  }

  Widget _crearPassword(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              labelText: 'Contraseña',
              labelStyle: TextStyle(fontSize: 17.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                  borderRadius: BorderRadius.circular(25.0)),
              //counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBotonRegistro(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: Center(
                child: ClayContainer(
                    borderRadius: 15,
                    curveType: CurveType.none,
                    color: Color.fromRGBO(227, 227, 227, 1),
                    depth: 15,
                    spread: 7,
                    child: RaisedButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 15.0),
                        child: Text('Registrar'),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.0,
                      //color: Color.fromRGBO(227, 227, 227, 1.0),
                      onPressed: snapshot.hasData
                          ? () => _register(context, bloc)
                          : null,
                    ))));
      },
    );
  }

  _register(BuildContext context, SignUpBloc bloc) async {
    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.passw,
        bloc.city, bloc.age, bloc.name, bloc.description, foto);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home', arguments: info['token']);
    } else {
      utils.mostrarAlerta(context, 'Revisar Campos ${info['mensaje']}');
    }

    //Navigator.pushNamed(context, 'home');
  }
}
