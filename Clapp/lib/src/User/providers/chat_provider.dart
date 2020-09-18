import 'dart:convert';

import 'package:Clapp/src/User/models/chat_model.dart';
import 'package:Clapp/src/User/models/mensaje_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class ChatProvider {
  final String _url = utils.url;

  Future<bool> crearChat(ChatModel chatModel) async {
    final url = '$_url/saveChat';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: chatModelToJson(chatModel));

    print(resp.statusCode);

    return true;
  }
  Future<bool> crearMensaje(MensajeModel mensajeModel,String fecha) async {
    final url = '$_url/saveMessage/$fecha';
    print("bandera 1");
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: messageModelToJson(mensajeModel));

    print(resp.statusCode);

    return true;
  }


  Future<List<ChatModel>> cargarChats(String id) async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllChats/$id';
    final rsp = await http.get(url);
   
    final Iterable decodeData = json.decode(rsp.body);
    
    List<ChatModel> chatModels = new List();
    if (decodeData == null) return [];

    chatModels =
        decodeData.map((model) {
          Iterable decodeMessage = model["mensajes"];
          List<MensajeModel> msgs=decodeMessage.map((e) => MensajeModel.fromJson(e)).toList();
          ChatModel aux= ChatModel.fromJson(model);
          aux.mensajes=msgs;
          return aux;
          }).toList();
    
    return chatModels;
  }

}
