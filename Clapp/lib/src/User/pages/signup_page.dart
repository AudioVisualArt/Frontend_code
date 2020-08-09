
import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/bloc/signup_bloc.dart';
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

    final bloc = Provider.ofSignUp(context);
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
          //_fotoDePerfil(bloc),
          SizedBox(height: 30.0),
          _registroNombre(bloc),
          SizedBox(height: 30.0),
          _registroEmail(bloc),
          SizedBox(height: 30.0),
          _registroPassword(bloc),
          SizedBox(height: 30.0),
          _registroPassword2(bloc),
          SizedBox(height: 30.0),
          _crearBotonSignUp(bloc)

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
  Widget _registroNombre(SignUpBloc bloc) {
    return StreamBuilder(

      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(

          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.person,
                  color: Color.fromRGBO(89, 122, 121, 1.0)),
              hintText: 'Señor Ejemplo',
              labelText: 'Nombre',
              errorText: snapshot.error,

            ),
            onChanged: bloc.changeNombre,

          ),

        );
      },

    );
  }
  Widget _registroPassword(SignUpBloc bloc){

    return StreamBuilder(

      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        return Container(

          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline,color: Color.fromRGBO(89, 122, 121, 1.0)),
                labelText: 'Contraseña',
                //counterText: snapshot.data,
                errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),

        );
      },
    );
 }

  Widget _registroPassword2(SignUpBloc bloc){

    return StreamBuilder(

      stream: bloc.password2Stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        return Container(

          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline,color: Color.fromRGBO(89, 122, 121, 1.0)),
                labelText: 'Confirme su contraseña',
                //counterText: snapshot.data,
                errorText: snapshot.error
            ),
            onChanged: bloc.changePassword2,
          ),

        );
      },
    );
  }
  Widget _registroUbicacion(SignUpBloc bloc){

    return StreamBuilder(

      stream: bloc.password2Stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        return Container(

          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.location_on,color: Color.fromRGBO(89, 122, 121, 1.0)),
                labelText: 'Ingrese su ubicacion',
                //counterText: snapshot.data,
                errorText: snapshot.error
            ),
            onChanged: bloc.changePassword2,
          ),

        );
      },
    );
  }

}
Widget _crearBotonSignUp(SignUpBloc bloc){

  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0 ,vertical: 15.0),
          child: Text('Sign Up'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        color: Color.fromRGBO(227, 227, 227, 1.0),
        onPressed: (){Navigator.pushNamed(context, 'signUp');},
      );
    },
  );
}

Widget _fotoDePerfil(SignUpBloc bloc) {
}