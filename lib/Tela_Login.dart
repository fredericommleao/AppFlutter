// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names
import 'dart:convert';
import 'package:aplicativo/Model/dados_parametros.dart';
import 'package:aplicativo/Tela_Parametros.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo/requisicao_post_http.dart';
import 'package:aplicativo/Values/keys.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bem vindo",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Sign in Continue",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                ),
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
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "SENHA",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade700),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 223, 135, 4),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextButton(
                      onPressed: () async {
                        fazerLogin();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }

  void fazerLogin() {}

  /*
  void salva_nome() {
    name_param name = name_param(nameController.text);

    salva_na_memoria_nome(name);
  }

  void salva_na_memoria_nome(name_param user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", json.encode(user.toJson()));
  }

  void salva_senha() {
    pass_param senha = pass_param(passwordController.text);

    salva_na_memoria_senha(senha);
  }

  void salva_na_memoria_senha(pass_param pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("senha", json.encode(pass.toJson()));
  }

  void fazer_login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? nome = prefs.getString("name");
    String? senha = prefs.getString("pass");
    String? ip = prefs.getString("ip");
    String? porta = prefs.getString("porta");

    //loginAPI.login(nome!, senha!, ip!, porta!);
    print(nome);
    print(senha);
    print(ip);
    print(porta);
  }
}
*/

  _navegaHomepage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => entrou()));
  }
}
