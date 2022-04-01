// ignore_for_file: prefer_const_constructors, unused_element, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison
import 'dart:convert';

import 'package:aplicativo/Model/Parametros.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUserDialog extends StatefulWidget {
  final Function(Parametros) addUser;
  AddUserDialog(this.addUser);

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  @override
  void initState() {
    super.initState();
    initialGetSaved();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          controller: controller,
        ),
      );
    }

    var ipController = TextEditingController();
    var portaController = TextEditingController();

    void initialGetSaved() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> jsondatais =
          jsonDecode(prefs.getString('key_parametros')!);

      var param = Parametros.fromJson(jsondatais);

      if (jsondatais.isNotEmpty) {
        print(param.ip);
        print(param.porta);

        ipController.value = TextEditingValue(text: param.ip);
        ipController.value = TextEditingValue(text: param.porta);
      }
    }

    void storeParamData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Parametros parametros =
          Parametros(ipController.text, portaController.text);

      String paramet = jsonEncode(parametros);

      print(paramet);

      prefs.setString('key_parametros', paramet);
    }

    return Container(
      padding: EdgeInsets.all(20),
      height: 400,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Digite o novo endereço IP e '
              'porta do servidor. ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.all(
                15.0,
              ),
            ),
            buildTextField('IP', ipController),
            Padding(
              padding: EdgeInsets.all(
                5.0,
              ),
            ),
            buildTextField('PORTA', portaController),
            Padding(
              padding: EdgeInsets.all(
                15.0,
              ),
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () async {
                final user =
                    Parametros(ipController.text, portaController.text);

                widget.addUser(user);

                storeParamData();

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  primary: Colors.orange,
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void initialGetSaved() {}
}
