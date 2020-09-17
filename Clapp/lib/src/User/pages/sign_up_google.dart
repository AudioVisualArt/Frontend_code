import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/bloc/signup_bloc.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/User/widgets/background_login.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class SignUpGoogle extends StatefulWidget {
  UserModel userModel;
  SignUpGoogle({Key key, this.userModel}) : super(key: key);

  @override
  _SignUpGoogle createState() => _SignUpGoogle();
}

class _SignUpGoogle extends State<SignUpGoogle> {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute
        .of(context)
        .settings
        .arguments;
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

      ),
    );
  }

  Widget _signUp(BuildContext context) {
    UserModel user = ModalRoute
        .of(context)
        .settings
        .arguments;
    final bloc = Provider.ofSignUp(context);
    final size = MediaQuery
        .of(context)
        .size;

    final container = Container(
      width: size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 40.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
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
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
          SizedBox(height: 40.0),
          _registroAge(bloc),
          //SizedBox(height: 30.0),
         // _crearPassword(bloc),
          SizedBox(height: 30.0),
          _registroCity(bloc),
          SizedBox(height: 30.0),
          _registroDescription(bloc),
          SizedBox(height: 30.0),
          _crearBotonRegistro(bloc, user),

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
              labelText: 'Edad',
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
            decoration: InputDecoration(
              icon: Icon(Icons.text_fields,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'cuentanos de ti!',
              labelText: 'Descripcion',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeDescription,
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
              //counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBotonRegistro(SignUpBloc bloc, UserModel user) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Color.fromRGBO(227, 227, 227, 1.0),
          onPressed:
            () => _register(context, bloc, user)
              ,
        );
      },
    );
  }

  _register(BuildContext context, SignUpBloc bloc, UserModel user) async {
    Map info = await usuarioProvider.nuevoUsuarioGoogle(
        bloc.city, bloc.age, bloc.description, bloc.passw, user);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home', arguments: info['token']);
    } else {
      utils.mostrarAlerta(context, 'Revisar Campos ${info['mensaje']}');
    }
  }
}