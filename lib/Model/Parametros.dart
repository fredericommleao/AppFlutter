// ignore_for_file: file_names, unused_import, prefer_collection_literals
import 'dart:convert';

class Parametros {
  final String ip;
  final String porta;

  Parametros(this.ip, this.porta);

  Parametros.fromJson(Map<String, dynamic> json)
      : ip = json['ip'],
        porta = json['porta'];

  Map<String, dynamic> toJson() => {'ip': ip, 'porta': porta};
}
