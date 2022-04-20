// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names, await_only_futures, avoid_unnecessary_containers, deprecated_member_use
import 'dart:convert';

import 'package:aplicativo/servidores.dart';
import 'package:aplicativo/tela_entrou.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/*
  tela de login inicial
 */
class tela_login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<tela_login> {
  //captura texto textfield
  final TextEditingController nameController = TextEditingController();

  //captura texto textfield
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 250, 250, 250),
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
                                _navegaHomepage(context);
                              },
                              child: const Text(
                                'Alterar servidor',
                                style: TextStyle(
                                    fontSize: 20,
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
                  color: Color.fromARGB(255, 223, 135, 4),
                  size: 50,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'web/LOGO.png',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "USUÁRIO",
                    labelStyle:
                        TextStyle(fontSize: 15, color: Colors.grey.shade900),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "SENHA",
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade900,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.center,
                  height: size.height / 8,
                  child: ElevatedButton(
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                    onPressed: () {
                      PostHttp(nameController.text, passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                  ),
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

      print(resposta.contentLength);

      if (resposta.contentLength == 234) {
        usuario_senha_incorreto();
      } else {
        var responseFull = json.decode(resposta.body);
        _navegaEntrou(context);
        print(responseFull);
      }
    } catch (exception) {
      enderecoNaoEncontrou();
    }
  }

  enderecoNaoEncontrou() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Erro, endereço inexistente",
          style: TextStyle(fontSize: 20),
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

  usuario_senha_incorreto() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Usuário ou senha incorretos.",
          style: TextStyle(fontSize: 20),
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

  _navegaEntrou(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Entrou()));
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Servidores()));
  }
}
