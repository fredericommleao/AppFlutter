// ignore_for_file: camel_case_types, avoid_print, body_might_complete_normally_nullable
import 'package:http/http.dart' as http;
import 'dart:convert';

class loginAPI {
  static Future<void> login(var ip, var porta, String user, String pass) async {
    var requisicao = Uri.parse(
        'http://$ip:$porta/mge/service.sbr?outputType=json&serviceName=MobileLoginSP.login');

    var body = json.encode({
      "serviceName": "MobileLoginSP.login",
      "requestBody": {
        "NOMUSU": {"\$": user},
        "INTERNO": {"\$": pass}
      }
    });

    var resposta = await http.post(requisicao,
        headers: {"Content-Type": "application/json"}, body: body);

    var responseFull = json.decode(resposta.body);

    print(responseFull);
  }
}
