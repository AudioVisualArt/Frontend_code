
import 'package:Clapp/src/User/bloc/provider_SignUp.dart';
import 'package:Clapp/src/User/bloc/signup_bloc.dart';
import 'package:Clapp/src/User/widgets/background_appbar.dart';
import 'package:Clapp/src/User/widgets/background_login.dart';
import 'package:flutter/material.dart';



class SignUp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(text: "Registro"),
          _signUp(context)
        ],
      ),
    );
  }

  Widget _signUp(BuildContext context) {
    final bloc = ProviderSignUp.of(context);
    final size = MediaQuery
        .of(context)
        .size;


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
                spreadRadius: 3.0
            ),
          ]
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          _registroEmail(bloc),
          //SizedBox(height: 30.0),
          //_crearPassword(bloc),
          //SizedBox(height: 30.0),
          //_crearBotonSingIn(bloc),
          //SizedBox(height: 30.0),
          //_crearBotonSignUp(bloc),
        ],
      ),
    );
    return SingleChildScrollView(
        child: Column(

          children: <Widget>[

            SafeArea(
                child: Container(
                  height: 180.0,
                )
            ),
            container,

            SizedBox(height: 100.0),

          ],
        )
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
}