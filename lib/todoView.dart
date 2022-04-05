// ignore_for_file: prefer_const_constructors, file_names, no_logic_in_create_state, use_key_in_widget_constructors, must_be_immutable, deprecated_member_use
import 'package:aplicativo/Model/Parametros.dart';
import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  Parametros parametros;
  TodoView({required this.parametros}) : super();

  @override
  _TodoViewState createState() => _TodoViewState(parametros: parametros);
}

class _TodoViewState extends State<TodoView> {
  Parametros parametros;
  _TodoViewState({required this.parametros});
  TextEditingController ipController = TextEditingController();
  TextEditingController portaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ipController.text = parametros.ip;
    portaController.text = parametros.porta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(240, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        elevation: 25,
        backgroundColor: Color.fromARGB(255, 223, 135, 4),
        title: Text(
          "Novo servidor",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
      body: AlertDialog(
        title: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                'DIGITE O IP E PORTA DO NOVO SERVIDOR',
                style: TextStyle(fontSize: 18.5),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: colorOverride(TextField(
                onChanged: (data) {
                  parametros.ip = data;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Digite o IP",
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: ipController,
              ))),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: colorOverride(TextField(
                maxLines: 1,
                onChanged: (data) {
                  parametros.porta = data;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Digite a porta",
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: portaController,
              ))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromARGB(255, 223, 135, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {},
                  child: Text(
                    "${parametros.status ? '' : ''} ",
                    style: TextStyle(color: Colors.white),
                  )),
              VerticalDivider(
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  Navigator.pop(context, parametros);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorOverride(Widget child) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.orange,
      ),
      child: child,
    );
  }
}
