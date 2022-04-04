// ignore_for_file: camel_case_types, avoid_print, body_might_complete_normally_nullable
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class loginAPI {
  static Future<void> login(String user, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String ip = jsonEncode(prefs.getString("key_ip"));
    String porta = jsonEncode(prefs.getString("key_porta"));

    var ip_Uri = jsonDecode(ip);
    var porta_Uri = jsonDecode(porta);

    var requisicao = Uri.parse(
        'http://$ip_Uri:$porta_Uri/mge/service.sbr?outputType=json&serviceName=MobileLoginSP.login');

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

    var responseBody = responseFull['responseBody'];

    var jsessionid = responseBody['jsessionid'];

    var token = jsessionid['\$'];

    print(responseFull);
  }
}
