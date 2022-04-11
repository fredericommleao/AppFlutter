// ignore_for_file: file_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedValues {
  static exibirIp(int indice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var x = prefs.getString('parametros');
    List y = json.decode(x.toString());
    var z = y[indice];
    z = z['ip'];
    return z;
  }

  static exibirPorta(int indice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var x = prefs.getString('parametros');
    List y = json.decode(x.toString());
    var z = y[indice];
    z = z['porta'];
    return z;
  }
}
