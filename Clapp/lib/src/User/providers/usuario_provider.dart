import 'dart:convert';
import 'dart:io';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyBR-7495abfXjSlaHQsfO1hCD5Q-q8XnUs';
  final _prefs = new PreferenciasUsuario();
  final String _url = utils.url;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeData = json.decode(resp.body);

    //print(decodeData);

    if (decodeData.containsKey('idToken')) {
      _prefs.token = decodeData['idToken'];

      final url = '$_url/getUserByEmail/$email';
      final rsp = await http.get(url);

      UserModel userModel = UserModel.fromJson(json.decode(rsp.body));
      //print(rsp.body);

      return {'ok': true, 'user': userModel};
    } else {
      return {'ok': false, 'mensaje': decodeData['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password,
      String city, String age, String name, String description, File foto) async {



    final StorageReference postImageRef =
    FirebaseStorage.instance.ref().child('Usuarios');

    final StorageUploadTask uploadTask =
    postImageRef.child(email).putFile(foto);

    final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();


    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeData = json.decode(resp.body);

    //print('Decode Data' + decodeData.toString());

    if (decodeData.containsKey('idToken')) {
      _prefs.token = decodeData['idToken'];
     // print(_prefs.token);

      UserModel user = new UserModel();
      user.description = description;
      user.name = name;
      user.age = int.parse(age);
      user.rating = 0;
      user.cityResidence = city;
      user.email = email;
      user.photoUrl=imageUrl;

      final url = '$_url/saveUser';
      final resp = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: userModelToJson(user));

      print("id registro: ${resp.body}");

      user.id=resp.body;

      return {'ok': true, 'token': user};
    } else {
      return {'ok': false, 'mensaje': decodeData['error']['message']};
    }
  }

}
