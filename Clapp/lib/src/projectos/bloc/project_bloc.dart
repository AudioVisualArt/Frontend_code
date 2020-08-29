
import 'package:rxdart/rxdart.dart';

class ProjectBloc {
  final _contactoController    = BehaviorSubject<String>();
  //List<String> crew;
  //List<String>locations;
  final _proyectNameController    = BehaviorSubject<String>();
  final _projectTypeController    = BehaviorSubject<String>();
  final _descriptionController    = BehaviorSubject<String>();
  final _idController    = BehaviorSubject<String>();
  final _idUserController    = BehaviorSubject<String>();


  Stream<String> get contactoStream =>_contactoController.stream;
  //List<String> crew;
  //List<String>locations;
  Stream<String> get proyectNameStream =>_proyectNameController.stream;
  Stream<String> get projectTypeStream =>_projectTypeController.stream;
  Stream<String> get descriptionStream=>_descriptionController.stream;
  Stream<String> get idStream=>_idController.stream;
  Stream<String> get idUserStream=>_idUserController.stream;

  Function (String) get changecontacto=>_contactoController.sink.add;
  //List<String> crew;
  //List<String>locations;
  Function (String) get changeproyectName =>_proyectNameController.sink.add;
  Function (String) get changeprojectType=>_projectTypeController.sink.add;
  Function (String) get changedescription=>_descriptionController.sink.add;
  Function (String) get changeid=>_idController.sink.add;
  Function (String) get changeidUser=>_idUserController.sink.add;

  dispose(){
    _contactoController?.close();
    _proyectNameController?.close();
    _projectTypeController?.close();
    _descriptionController?.close();
    _idController?.close();
    _idUserController?.close();
  }

  String get contacto=>_contactoController.value;
  //List<String> crew;
  //List<String>locations;
  String get proyectName =>_proyectNameController.value;
  String get projectType=>_projectTypeController.value;
  String get description=>_descriptionController.value;
  String get id=>_idController.value;
  String get idUser=>_idUserController.value;
}