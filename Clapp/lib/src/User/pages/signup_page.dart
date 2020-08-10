import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/bloc/signup_bloc.dart';
import 'package:Clapp/src/User/widgets/background_login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(text: "Registro"), _signUp(context)],
      ),
    );
  }

  Widget _signUp(BuildContext context) {
    final bloc = Provider.ofSignUp(context);
    final size = MediaQuery.of(context).size;

    final container = Container(
      width: size.width * 0.85,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 50.0),
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
          SizedBox(height: 50.0),
          _registroEmail(bloc),
          SizedBox(height: 30.0),
          _crearPassword(bloc),
          SizedBox(height: 30.0),
          _crearBotonRegistro(bloc),
          //SizedBox(height: 30.0),
          //_crearBotonSignUp(bloc),
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
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
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
                labelText: 'Contrasenia',
                //counterText: snapshot.data,
                errorText: snapshot.error),
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
          onPressed: snapshot.hasData ? () => Text('Bien') : null,
        );
      },
    );
  }
}
