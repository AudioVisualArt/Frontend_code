import 'dart:async';
import 'package:Clapp/src/User/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc with Validator  {


  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _descriptionDescription = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _ageController = BehaviorSubject<String>();
  final _cityResidenceController = BehaviorSubject<String>();
  final _photoUrlController = BehaviorSubject<String>();

  //Recuperar los datos del Stream

  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get descriptionStream    => _descriptionDescription.stream.transform(validarDescription);
  Stream<String> get nameStream => _nameController.stream.transform(validarName);
  Stream<String> get ageStream    => _ageController.stream.transform(validarAge);
  Stream<String> get cityStream => _cityResidenceController.stream.transform(validarCity);
  Stream<String> get photoUrlStream => _photoUrlController.stream.transform(validarCity);


  Stream<bool> get formValidStream =>  Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar Valores al Stream

  Function (String) get changeEmail    => _emailController.sink.add;
  Function (String) get changePassword => _passwordController.sink.add;
  Function (String) get changeDescription    => _descriptionDescription.sink.add;
  Function (String) get changeName => _nameController.sink.add;
  Function (String) get changeAge    => _ageController.sink.add;
  Function (String) get changeCity => _cityResidenceController.sink.add;
  Function (String) get changePhotoUrl => _photoUrlController.sink.add;

  //Cerrar Streams
  dispose(){
    _emailController?.close();
    _passwordController?.close();
    _descriptionDescription?.close();
    _nameController?.close();
    _ageController?.close();
    _cityResidenceController?.close();
    _photoUrlController?.close();
  }

  //Obtener el último valor ingresado a los streams

  String get email => _emailController.value;
  String get passw => _passwordController.value;
  String get description => _descriptionDescription.value;
  String get name => _nameController.value;
  String get age => _ageController.value;
  String get city => _cityResidenceController.value;
  String get photo => _photoUrlController.value;

}