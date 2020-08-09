import 'dart:async';
import 'package:Clapp/src/User/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc with Validator  {


  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordController2 = BehaviorSubject<String>();

  //Recuperar los datos del Stream

  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get password2Stream => _passwordController2.stream.transform(validarPassword2);

  Stream<bool> get formValidStream =>  Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar Valores al Stream

  Function (String) get changeEmail    => _emailController.sink.add;
  Function (String) get changePassword => _passwordController.sink.add;
  Function (String) get changePassword2 => _passwordController2.sink.add;

  //Cerrar Streams
  dispose(){
    _emailController?.close();
    _passwordController?.close();
    _passwordController2?.close();
  }

  //Obtener el último valor ingresado a los streams

  String get email => _emailController.value;
  String get passw => _passwordController.value;
  String get passw2 => _passwordController2.value;

}