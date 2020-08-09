import 'package:Clapp/src/User/bloc/login_bloc.dart';
import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/widgets/background_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
              if(!currentFocus.hasPrimaryFocus){
                currentFocus.unfocus();
              }
            },
          child: Scaffold(
            body: Stack(
              
              children: <Widget>[
                
                Background(text:"Bienvenido a Clapp"),
                _loginForm(context),
              ],
            ),
      ),
    );
  }



  }
  
  Widget _loginForm(BuildContext context){

    final bloc = Provider.of(context);
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
              offset: Offset(0.0,5.0),
              spreadRadius: 3.0
            ),
          ]
        ),
        child: Column(
          children: <Widget>[
            Text('Sing In', style: TextStyle(fontSize: 20.0,fontFamily: "Raleway")),
            SizedBox(height: 50.0),
            _crearEmail(bloc),
            SizedBox(height: 30.0),
            _crearPassword(bloc),
            SizedBox(height: 30.0),
            _crearBotonSingIn(bloc),
            SizedBox(height: 30.0),
            _crearBotonSignUp(bloc),
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

          Text('¿Olvido la contraseña?'),
          SizedBox(height: 100.0),

        ],
      )
    );
  }

  Widget _crearEmail(LoginBloc bloc){

    return StreamBuilder(

      stream: bloc.emailStream,
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        
        return Container(

          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,color: Color.fromRGBO(89, 122, 121, 1.0)),
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

  Widget _crearPassword(LoginBloc bloc){

      return StreamBuilder(

        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
            return Container(

              padding: EdgeInsets.symmetric(horizontal: 20.0),

              child: TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline,color: Color.fromRGBO(89, 122, 121, 1.0)),
                  labelText: 'Contrasenia',
                  //counterText: snapshot.data,
                  errorText: snapshot.error
                ),
                onChanged: bloc.changePassword,
              ),

            );
        },
      );

  }

  Widget _crearBotonSingIn(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
           return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0 ,vertical: 15.0),
              child: Text('Sign In'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0.0,
            color: Color.fromRGBO(227, 227, 227, 1.0),
            onPressed: snapshot.hasData ? () =>_login(context,bloc) : null,
          );
      },
    );
  }
  Widget _crearBotonSignUp(LoginBloc bloc){

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


  //Metodo de Prueba No eliminar por favor

  _login( BuildContext context,LoginBloc bloc){
    print('===========');
    print('Email: ${bloc.email}');
    print('Passw: ${bloc.passw}');
    print('===========');

    Navigator.pushNamed(context, 'home');

  }

