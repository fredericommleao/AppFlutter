// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, await_only_futures, avoid_unnecessary_containers, deprecated_member_use
import 'dart:convert';
import 'package:aplicativo/tela_servidores.dart';
import 'package:aplicativo/tela_entrou.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';

class Autenticacao extends StatefulWidget {
  @override
  _AutenticacaoState createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  //captura texto textfield
  final TextEditingController nameController = TextEditingController();
  //captura texto textfield
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(195, 250, 250, 250),
        actions: [
          Padding(
              padding: EdgeInsets.only(
                right: 20.0,
              ),
              child: PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        ButtonBar(
                          children: [
                            TextButton(
                              onPressed: () {
                                navegaHomepage(context);
                              },
                              child: const Text(
                                'Alterar servidor',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                child: Icon(
                  Icons.read_more_outlined,
                  color: HexColor("#E8882B"),
                  size: 50,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'web/LOGO.png',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "USU??RIO",
                    labelStyle: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade900,
                      fontFamily: 'Montserrat',
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "SENHA",
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.5,
                      color: Colors.grey.shade900,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: 'Montserrat'),
                  ),
                  onPressed: () {
                    PostHttp(nameController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 85, vertical: 12.5),
                      primary: HexColor("#E8882B"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PostHttp(
    String user,
    String pass,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var ip = await prefs.getString('ip');
    var porta = await prefs.getString('porta');

    try {
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

      if (resposta.contentLength == 279) {
        navegaEntrou(context);
        mensagem(resposta.body);
      } else {
        mensagem(resposta.body);
      }
    } catch (exception) {
      enderecoNaoEncontrou();
    }
  }

  mensagem(String mgn) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          mgn,
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          FlatButton(
            color: Color.fromARGB(255, 223, 135, 4),
            child: Text(
              'OK',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  enderecoNaoEncontrou() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Erro, endere??o inexistente",
          style: TextStyle(fontSize: 17.5),
        ),
        actions: [
          FlatButton(
            color: Color.fromARGB(255, 223, 135, 4),
            child: Text(
              'OK',
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  navegaEntrou(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Entrou()));
  }

  navegaHomepage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Servidores()));
  }
}
