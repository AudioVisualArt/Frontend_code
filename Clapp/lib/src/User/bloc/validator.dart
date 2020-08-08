import 'dart:async';

class Validator{

  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink) {
      
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      }else{
        sink.addError('Email no cumple formato');
      }

    }
  );

  final validarNombre = StreamTransformer<String,String>.fromHandlers(
      handleData: (nombre, sink) {

        Pattern pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]';
        RegExp regExp = new RegExp(pattern);

        if (regExp.hasMatch(nombre)) {
          sink.add(nombre);
        }else{
          sink.addError('Nombre no cumple el formato');
        }

      }
  );


  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink) {
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('Mas de 6 caracteres por favor');
      }
    }
  );

  final validarPassword2 = StreamTransformer<String,String>.fromHandlers(
      handleData: (password, sink) {
        if(password.length >= 6){
          sink.add(password);
        }else{
          sink.addError('Mas de 6 caracteres por favor');
        }
      }
  );



}