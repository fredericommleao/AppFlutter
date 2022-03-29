// ignore_for_file: camel_case_types, file_names, unused_label, prefer_const_constructors, unused_element, use_key_in_widget_constructors, non_constant_identifier_names, avoid_print, deprecated_member_use
import 'package:aplicativo/Model/user.dart';
import 'package:aplicativo/Tela_Login.dart';
import 'package:aplicativo/user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class entrou extends StatefulWidget {
  @override
  _ParametroState createState() => _ParametroState();
}

class _ParametroState extends State<entrou> {
  late SharedPreferences IP_save;
  late SharedPreferences Porta_save;

  //List<Parametros>
  List<Parametros> parametroList = [];
  //captura texto textfield
  TextEditingController ipController = TextEditingController();
  //captura texto textfield
  TextEditingController portaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void addParam_Data(Parametros parametros) {
      setState(() {
        parametroList.add(parametros);
      });
    }

    void saveParam_Data() {}

    void showParam_Dialog() {
      showDialog(
        context: (context),
        builder: (_) {
          return AlertDialog(
            content: AddUserDialog(addParam_Data),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          showParam_Dialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 223, 135, 4),
          title: const Text('Servidores',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400))),
      body: Container(
        color: Color.fromARGB(43, 255, 255, 255),
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              margin: EdgeInsets.all(4),
              elevation: 10,
              child: ListTile(
                title: Text(
                  parametroList[index].ip,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  parametroList[index].porta,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onTap: () async {},
              ),
            );
          },
          itemCount: parametroList.length,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 223, 135, 4),
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> save_ip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key_ip', ipController.text);
    print(prefs.getString('key_ip'));
  }

  Future<void> save_porta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('key_porta'));
    prefs.setString('key_porta', portaController.text);
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => tela_login()));
  }
}
