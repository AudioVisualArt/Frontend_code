import 'dart:async';

import 'package:Clapp/src/User/bloc/validator.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator{


  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream

  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>  Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar Valores al Stream

  Function (String) get changeEmail    => _emailController.sink.add;
  Function (String) get changePassword => _passwordController.sink.add;

  //Cerrar Streams
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

  //Obtener el último valor ingresado a los streams

  String get email => _emailController.value;
  String get passw => _passwordController.value;


}