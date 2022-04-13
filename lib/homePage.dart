// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, unused_label, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, unused_local_variable
import 'dart:convert';
import 'package:aplicativo/Controller/sharedValues.dart';
import 'package:aplicativo/Tela_Login.dart';
import 'package:aplicativo/todoView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/Parametros.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

late SharedPreferences prefs;

class _HomePageState extends State<HomePage> {
  List todos = [];

  exibir() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('parametros');
    List todoList = jsonDecode(stringTodo.toString());
    for (var todo in todoList) {
      setState(() {
        todos.add(Parametros(porta: '', ip: '').fromJson(todo));
      });
    }
  }

  salvar() {
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('parametros', jsonEncode(items));
  }

  adicionar() async {
    Parametros t = Parametros(ip: '', porta: '');
    Parametros returnTodo = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TodoView(parametros: t)));
    setState(() {
      todos.add(returnTodo);
    });
    salvar();
  }

  alterar(int index) async {
    Parametros returnTodo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TodoView(parametros: todos.elementAt(index))));
    setState(() {});
    salvar();
  }

  delete(Parametros todo) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Atenção"),
              content: Text("Deseja realmente apagar ?"),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("No")),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      setState(() {
                        todos.remove(todo);
                      });
                      Navigator.pop(ctx);
                      salvar();
                    },
                    child: Text("Yes"))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    exibir();
  }

  Color appcolor = Color.fromARGB(255, 255, 255, 255);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          adicionar();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 223, 135, 4),
        title: Text("Servidores",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400)),
      ),
      body: Container(
        color: Color.fromARGB(43, 255, 255, 255),
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: prefs.getInt('indice') == index
                      ? Color.fromARGB(255, 243, 152, 15)
                      : Colors.white,
                  margin: EdgeInsets.all(4),
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(),
                    child: InkWell(
                      onTap: () async {
                        escolher_opcao(index);
                      },
                      child: gera_lista_tela(todos[index], index),
                    ),
                  ));
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 223, 135, 4),
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  escolher_opcao(int indice) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    alterar(indice);
                  },
                  child: Text('ALTERAR'),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () async {
                      SharedValues value = SharedValues(indice);
                      var x = await value.exibirIp();
                      var y = await value.exibirPorta();

                      value.marcarPadrao(indice);

                      value.padraoLogin(x, y);

                      _navegaHomepage(context);
                    },
                    child: Text('SELECIONAR'))
              ],
            ));
  }

  _navegaHomepage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => tela_login()));
  }

  gera_lista_tela(Parametros todo, index) {
    index++;
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.black))),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 223, 135, 4),
            child: Text("${index}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)),
          ),
        ),
        title: Row(
          children: [
            Text(
              todo.ip,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 25,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        subtitle: Wrap(
          children: <Widget>[
            Text(todo.porta,
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 20))
          ],
        ),
        trailing: InkWell(
            onTap: () {
              delete(todo);
            },
            child: Icon(Icons.delete,
                color: Color.fromARGB(255, 223, 135, 4), size: 30.0)));
  }
}
