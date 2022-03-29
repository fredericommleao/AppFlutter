// ignore_for_file: prefer_const_constructors, unused_element, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:aplicativo/Model/user.dart';
import 'package:flutter/material.dart';

class AddUserDialog extends StatefulWidget {
  final Function(Parametros) addUser;

  AddUserDialog(this.addUser);

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
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
              onPressed: () {
                final user =
                    Parametros(ipController.text, portaController.text);
                widget.addUser(user);
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
}
