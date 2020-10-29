import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'dart:convert';


class ActividadProvider{
    final String _url = utils.url;
    Future<bool> crearActividad(ActividadModel act,String userid) async {
    final url = '$_url/saveActivity/$userid';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: actividadModelToJson(act));

    print(resp.statusCode);

    return true;
  }

  Future<List<ActividadModel>> cargarActividades(String userid) async {
      final url = '$_url/getAllActivities/$userid';
      final rsp = await http.get(url);
      String source = Utf8Decoder().convert(rsp.bodyBytes);

      final Iterable decodeData = json.decode(source);
      if (decodeData == null) return null;
      final actividades = decodeData.map((model) => ActividadModel.fromJson(model)).toList();
      actividades.sort((b,a)=>a.fecha.compareTo(b.fecha));
      return actividades;
  }

}