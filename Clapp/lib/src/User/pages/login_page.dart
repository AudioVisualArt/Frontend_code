import 'package:Clapp/src/User/models/mensaje_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/User/bloc/login_bloc.dart';
import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:Clapp/src/User/widgets/background_login.dart';

class LoginPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Background(text: "Bienvenido a Clapp"),
              _loginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    final container = Container(
      width: size.width * 0.85,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 50.0),
      decoration: BoxDecoration(
          color: Colors.white70.withOpacity(1),
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
          Text('Inicio de Sesión',
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: "Raleway",
              )),
          SizedBox(height: 45.0),
          _crearEmail(bloc),
          SizedBox(height: 30.0),
          _crearPassword(bloc),
          SizedBox(height: 30.0),
          _crearBotonSingIn(bloc),
          SizedBox(height: 30.0),
          _crearBotonSignUp(bloc),
          SizedBox(height: 30.0),
          _loginGmail(context)
        ],
      ),
    );

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SafeArea(
            child: Container(
          height: 180.0,
        )),
        container,
      ],
    ));
  }

  Widget _crearEmail(LoginBloc bloc) {
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
              labelText: 'Correo Electrónico',
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

  Widget _crearPassword(LoginBloc bloc) {
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
                labelStyle: TextStyle(
                    //color: Color.fromRGBO(0, 51, 51, 0.8),
                    //fontWeight: FontWeight.bold,
                    fontSize: 17.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
                    borderRadius: BorderRadius.circular(25.0)),
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBotonSingIn(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: Center(
                child: ClayContainer(
                    borderRadius: 15,
                    curveType: CurveType.none,
                    color: Color.fromRGBO(227, 227, 227, 1),
                    depth: 20,
                    spread: 5,
                    child: RaisedButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 70.0, vertical: 15.0),
                        child: Text('Iniciar Sesión'),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.0,
                      color: Color.fromRGBO(227, 227, 227, 1.0),
                      onPressed:
                          snapshot.hasData ? () => _login(context, bloc) : null,
                    ))));
      },
    );
  }

  Widget _crearBotonSignUp(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: Center(
                child: ClayContainer(
                    borderRadius: 15,
                    curveType: CurveType.none,
                    color: Color.fromRGBO(227, 227, 227, 1),
                    depth: 25,
                    spread: 5,
                    child: RaisedButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 15.0),
                        child: Text('Regístrate'),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0.0,
                      color: Color.fromRGBO(227, 227, 227, 1.0),
                      onPressed: () {
                        Navigator.pushNamed(context, 'signUp');
                      },
                    ))));
      },
    );
  }

  Widget _loginGmail(context) {
    return SizedBox(
        width: 253,
        child: RaisedButton(
          child: Row(
            children: [
              Container(
                child: Image(
                  image: AssetImage(
                    'assets/img/google.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
                height: 36,
                width: 36,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                  child: Center(
                    child: Text(
                      "Ingresa con Gmail",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: "Raleway",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Color.fromRGBO(65, 133, 244, 1.0),
          onPressed: () {
            onGoogleSignIn(context);
          },
        ));
    /* InkWell(
      onTap: (){
        onGoogleSignIn(context);
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0
        ),
        width: 260,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(89, 122, 121, 1.0),//arriba
                  Color.fromRGBO(112, 252, 118, 0.8)//bajo
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp

            )

        ),

        child: Center(
          child: Text(
            "Ingresa con Gmail",
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Raleway",
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),

          ),
        ),

      ),
    );

    */
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser userg = await usuarioProvider.loginGmail();
    UserModel user = await usuarioProvider.getUserGoogle(userg);

    if (user.description == null) {
      Navigator.pushReplacementNamed(context, 'register_google',
          arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, 'home_principal', arguments: user);
    }
  }

  _login(BuildContext context, LoginBloc bloc) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.passw);

    // UserModel user = info['user'];
    // print('Info User:  ' + user.id + '\n');

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home_principal', arguments: info['user']);
    } else {
      utils.mostrarAlerta(
          context, 'Usuario o Contraseña Invalidos ${info['mensaje']}');
    }
  }
}
