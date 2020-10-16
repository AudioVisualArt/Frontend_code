import 'dart:convert';
import 'dart:io';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyBR-7495abfXjSlaHQsfO1hCD5Q-q8XnUs';
  final _prefs = new PreferenciasUsuario();
  final String _url = utils.url;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<Map<String, dynamic>> nuevoUsuario(
      String email,
      String password,
      String city,
      String age,
      String name,
      String description,
      File foto) async {
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
      user.photoUrl = imageUrl;

      final url = '$_url/saveUser';
      final resp = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: userModelToJson(user));

      print("id registro: ${resp.body}");

      user.id = resp.body;

      return {'ok': true, 'token': user};
    } else {
      return {'ok': false, 'mensaje': decodeData['error']['message']};
    }
  }

  Future<FirebaseUser> loginGmail() async {
    // hold the instance of the authenticated user
    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      user = await _auth.currentUser();
      return user;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final user = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));
      return user;
    }
    return user;
  }

  Future<UserModel> getUserGoogle(FirebaseUser userg) async {
    print("la url que se trata de acceder es: $_url");
    print("con el id usuario: ${userg.email}");
    final url = '$_url/getUserByEmail/${userg.email}';
    final rsp = await http.get(url);

    if (rsp.body.isEmpty) {
      UserModel newuser = new UserModel();
      newuser.email = userg.email;
      newuser.name = userg.displayName;
      newuser.photoUrl = userg.photoUrl;

      final url = '$_url/saveUser';
      final resp = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: userModelToJson(newuser));
      newuser.id = resp.body;
      return newuser;
    } else {
      UserModel userm = UserModel.fromJson(json.decode(rsp.body));
      return userm;
    }
  }

  Future<Map> nuevoUsuarioGoogle(String city, String age, String description,
      String password, UserModel user) async {
    user.cityResidence = city;
    user.age = int.parse(age);
    user.description = description;

    final url = '$_url/updateUser/${user.id}';
    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: userModelToJson(user));

    print('Edit 1: ${resp.body.trim()} ');

    return {'ok': true, 'token': user};
  }

  Future<UserModel> obtenerUsuario(String id) async {
    final url = '$_url/getUser/$id';
    final rsp = await http.get(url);
    print('Usuario: ' + rsp.body);

    final decodeData = json.decode(rsp.body);
    if (decodeData == null) return null;

    UserModel user = UserModel.fromJson(decodeData);

    return user;
  }


}
