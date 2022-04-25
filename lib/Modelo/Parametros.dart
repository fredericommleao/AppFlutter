// ignore_for_file: file_names, unused_import, prefer_collection_literals
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Parametros {
  late String ip;
  late String porta;

  Parametros({required this.ip, required this.porta}) {
    ip = ip;
    porta = porta;
  }

  toJson() {
    return {
      "porta": porta,
      "ip": ip,
    };
  }

  fromJson(json) {
    return Parametros(ip: json['ip'], porta: json['porta']);
  }
}
