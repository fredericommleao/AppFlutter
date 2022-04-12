// ignore_for_file: file_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedValues {
  late int indice;

  SharedValues(this.indice);

  exibirIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var x = prefs.getString('parametros');
    List y = json.decode(x.toString());
    var z = y[indice];
    z = z['ip'];
    return z;
  }

  exibirPorta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var x = prefs.getString('parametros');
    List y = json.decode(x.toString());
    var z = y[indice];
    z = z['porta'];
    return z;
  }

  padraoLogin(var ip, var porta) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', ip);
    prefs.setString('porta', porta);
  }
}
