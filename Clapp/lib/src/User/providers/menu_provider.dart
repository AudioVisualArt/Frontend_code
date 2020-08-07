

import 'dart:convert';

import 'package:flutter/services.dart';

class _MenuProvider {

  List<dynamic> opciones = [];

  _MenuProvider(){
    //cargarData();
  }

  Future<List<dynamic>>cargarData() async {

    final resp = await rootBundle.loadString('data/menu_Clapp.jason');
      
        Map dataMap = json.decode(resp);
        opciones = dataMap['rutas'];
      
      return opciones;
  }
}

final menuProvider = new _MenuProvider();