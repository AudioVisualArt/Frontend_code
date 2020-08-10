import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyBR-7495abfXjSlaHQsfO1hCD5Q-q8XnUs';
  final _prefs = new PreferenciasUsuario();

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

    print(decodeData);

    if (decodeData.containsKey('idToken')) {
      _prefs.token = decodeData['idToken'];
      return {'ok': true, 'token': decodeData['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeData['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeData = json.decode(resp.body);

    print(decodeData);

    if (decodeData.containsKey('idToken')) {
      _prefs.token = decodeData['idToken'];
      return {'ok': true, 'token': decodeData['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeData['error']['message']};
    }
  }
}
