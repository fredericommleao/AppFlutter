// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names
import 'package:aplicativo/homePage.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo/requisicao_post_http.dart';

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
                right: 25.0,
              ),
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        ButtonBar(
                          children: [
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
                        )
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
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
                          TextStyle(fontSize: 15, color: Colors.grey.shade900),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 10,
                    width: size.width,
                    child: ElevatedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        fazerLogin();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 120, vertical: 20),
                          primary: Colors.orange,
                          textStyle:
                              TextStyle(fontSize: 25, color: Colors.black12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fazerLogin() async {
    return loginAPI.login('', '', nameController.text, passwordController.text);
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
