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




  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink) {
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('Mas de 6 caracteres por favor');
      }
    }
  );

  final validarDescription = StreamTransformer<String,String>.fromHandlers(
      handleData: (description, sink) {
        if(description.length > 0){
          sink.add(description);
        }else{
          sink.addError('ingrese una descripcion por favor');
        }
      }
  );
  final validarName = StreamTransformer<String,String>.fromHandlers(
      handleData: (description, sink) {
        if(description.length > 0){
          sink.add(description);
        }else{
          sink.addError('porfavor ingrese su nombre');
        }
      }
  );
  final validarAge = StreamTransformer<String,String>.fromHandlers(
      handleData: (description, sink) {

      }
  );
  final validarCity= StreamTransformer<String,String>.fromHandlers(
      handleData: (description, sink) {
        if(description.length > 0){
          sink.add(description);
        }else{
          sink.addError('porfavor ingrese su nombre');
        }
      }
  );



}