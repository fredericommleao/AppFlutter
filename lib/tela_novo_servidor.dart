// ignore_for_file: prefer_const_constructors, file_names, no_logic_in_create_state, use_key_in_widget_constructors, must_be_immutable, deprecated_member_use
import 'package:aplicativo/Modelo/Parametros.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class NovoServidor extends StatefulWidget {
  Parametros parametros;
  NovoServidor({required this.parametros}) : super();

  @override
  _NovoServidorState createState() =>
      _NovoServidorState(parametros: parametros);
}

class _NovoServidorState extends State<NovoServidor> {
  Parametros parametros;
  _NovoServidorState({required this.parametros});
  //atributo responsavel por capturar o ip digitado
  TextEditingController ipController = TextEditingController();
  //atributo responsavel por capturar a porta digitada
  TextEditingController portaController = TextEditingController();

  //variavel que recebe o formato válido da Porta
  var porta = MaskTextInputFormatter(mask: '####');

  @override
  void initState() {
    super.initState();
    ipController.text = parametros.ip;
    portaController.text = parametros.porta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 25,
        backgroundColor: HexColor("#E8882B"),
        title: Text("Novo servidor",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ariel',
                fontSize: 30,
                fontWeight: FontWeight.w300)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                  child: (TextField(
                //inputFormatters: [ip],
                onChanged: (data) {
                  parametros.ip = data;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 12.5),
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
                height: 15,
              ),
              Container(
                  child: (TextField(
                inputFormatters: [porta],
                maxLines: 1,
                onChanged: (data) {
                  parametros.porta = data;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 12.5),
                  labelText: "Digite a porta",
                  hintText: "0000",
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
          color: HexColor("#E8882B"),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {},
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              VerticalDivider(
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 30,
                ),
                onPressed: () {
                  regraValidacao();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /*Regra de validação de inputs: 
  - inputs não podem ser vázios, 
  - formato do ip deve ser válido 
  - formato da porta deve conter 4 digitos 
  
   *As duas funções abaixo, são responsavéis pela validação das regras,
    a função regraValidacao() realiza as tomadas de decisões e caso não 
    seja valido retorna a funcao mensagemInvalido(), 
    caso os inputs sejam válidos o último else retorna no Navigator 
    que fecha a rota do widget repassando os novos parametros para a lista.
  
  */

  regraValidacao() {
    var ip = ipController.text.length;
    var porta = portaController.text.length;
    if (ipController.text == '' || portaController.text == '') {
      return mensagemInvalido();
    } else if (ip < 13 || porta < 4) {
      return mensagemInvalido();
    } else {
      return Navigator.pop(context, parametros);
    }
  }

  mensagemInvalido() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Erro, possíveis causas:",
          style: TextStyle(fontSize: 17.5),
        ),
        content: Text(
          'Campo(s) vazio(s)\nformato de IP '
          'inválido\nformato de Porta inválida',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          FlatButton(
            color: HexColor("#E8882B"),
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
}
