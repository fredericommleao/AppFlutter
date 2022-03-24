// ignore_for_file: camel_case_types, file_names, unused_label, prefer_const_constructors, unused_element, use_key_in_widget_constructors, non_constant_identifier_names, avoid_print
import 'dart:convert';
import 'package:aplicativo/Tela_Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/dados_parametros.dart';

class entrou extends StatefulWidget {
  @override
  _ParametroState createState() => _ParametroState();
}

class _ParametroState extends State<entrou> {
  //captura texto textfield
  final TextEditingController ipController = TextEditingController();
  //captura texto textfield
  final TextEditingController portaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Servidores',
              style: TextStyle(color: Colors.white, fontSize: 24))),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Informe os parâmetros',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            actions: <Widget>[
              TextField(
                  controller: ipController,
                  decoration: InputDecoration(
                      labelText: "ENDEREÇO IP",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)))),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: portaController,
                  decoration: InputDecoration(
                      labelText: "PORTA",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)))),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.orange,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //salva_ip();
                  //salva_porta();
                  _navegaHomepage(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

/*
  
 void salva_na_memoria_ip(ipParam ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ip", json.encode(ip.toJson()));
  }

  void salva_porta() {
    porta_param porta = porta_param(portaController.text);
    salva_na_memoria_porta(porta);
  }

  void salva_na_memoria_porta(porta_param porta) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("porta", json.encode(porta.toJson()));
  }
}
*/

  /*void _doSighUp() {
    ipParam ip = ipParam(ipController.text);
    _saveUser(ip);
  }*/

  void _doSignUp() {
    ipParam ip = ipParam(ipController.text);

    print(ip);
    _saveUser(ip);
  }

  void _saveUser(ipParam ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ip", json.encode(ip.toJson()));
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => tela_login()));
  }
}
