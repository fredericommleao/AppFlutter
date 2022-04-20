// ignore_for_file: camel_case_types, avoid_print, body_might_complete_normally_nullable, non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use
import 'package:http/http.dart' as http;
import 'dart:convert';

class loginAPI {
  late var ip;
  late var porta;

  loginAPI(this.ip, this.porta);

  PostHttp(String user, String pass) async {
    try {
      var requisicao = Uri.parse(
          'http://socialdistribuidora.no-ip.biz:8280/mge/service.sbr?outputType=json&serviceName=MobileLoginSP.login');

      var body = json.encode({
        "serviceName": "MobileLoginSP.login",
        "requestBody": {
          "NOMUSU": {"\$": user},
          "INTERNO": {"\$": pass}
        }
      });

      var resposta = await http.post(requisicao,
          headers: {"Content-Type": "application/json"}, body: body);

      print(resposta.contentLength);
      var responseFull = json.decode(resposta.body);
      print(responseFull);
    } catch (exception) {
      print('erro');
    }
  }
}
