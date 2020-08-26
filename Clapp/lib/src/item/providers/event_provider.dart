import 'dart:convert';
import 'dart:html';

import 'package:Clapp/src/item/model/event_models.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class EquipmentProvider {
  final String _url = utils.url;

  Future<bool> crearEvento(EventModel eventModel) async {
    final url = '$_url/saveEvent';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: eventModelToJson(eventModel));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarEvent(EventModel eventModel) async {
    final url = '$_url/updateEvent${eventModel.id}';

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: eventModelToJson(eventModel));

    print('Edit 1: ${resp.body.trim()} ');

    final decodeData = json.decode(resp.body);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<EventModel>> cargarEventos() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllEvents';
    final rsp = await http.get(url);
    print(rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<EventModel> eventModels = new List();
    if (decodeData == null) return [];

    eventModels =
        decodeData.map((model) => EventModel.fromJson(model)).toList();

    return eventModels;
  }

  Future<int> borrarEvento(String id) async {
    final url = '$_url/deleteEvent/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}
