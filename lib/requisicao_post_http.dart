// ignore_for_file: camel_case_types, avoid_print

import 'package:aplicativo/encapsula_json_obj.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'encapsula_json_obj.dart';

class loginAPI {
  static Future<Jsessionid> login(String user, String password) async {
    var requisicao = Uri.parse(
        'http://192.168.100.2:8380/mge/service.sbr?outputType=json&serviceName=MobileLoginSP.login');

    var body = json.encode({
      "serviceName": "MobileLoginSP.login",
      "requestBody": {
        "NOMUSU": {"\$": user},
        "INTERNO": {"\$": password}
      }
    });

    var resposta = await http.post(requisicao,
        headers: {"Content-Type": "application/json"}, body: body);

    var responseFull = json.decode(resposta.body);

    var responseBody = responseFull['responseBody'];

    var jsessionid = responseBody['jsessionid'];

    var token = jsessionid['\$'];

    Jsessionid x = Jsessionid(token);

    print(x.getNome);

    return x;
  }
}
