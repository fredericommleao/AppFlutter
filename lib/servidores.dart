// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, unused_label, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, unused_local_variable, avoid_unnecessary_containers, deprecated_member_use
import 'dart:convert';
import 'package:aplicativo/Controller/sharedValues.dart';
import 'package:aplicativo/tela_login.dart';
import 'package:aplicativo/novo_servidor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/Parametros.dart';

class Servidores extends StatefulWidget {
  @override
  _ServidoresState createState() => _ServidoresState();
}

late SharedPreferences
    //variavel global de sharedPreferences que é instanciada diversas vezes na classe
    prefs;

class _ServidoresState extends State<Servidores> {
  /*Atributo do tipo lista, que será chamado nas principais funções da classe, pois é ela que armazena
  */
  List todos = [];

  /*
  Essa função é responsável por recuperar os parametros digitado pelo usuário e exibir na tela,
  o sharedpreferences faz a busca dos que já foi salvado na memoria e os carrega para a exibição.
  o setState() é quem faz todo o gerenciamento de estado da tela, por isso que se tirar 
  o conteúdo de dentro dele a lista não irá aparecer
  */
  exibir_lista() async {
    prefs = await SharedPreferences.getInstance();
    String? stringLista = prefs.getString('parametros');
    List dateList = jsonDecode(stringLista.toString());
    for (var todo in dateList) {
      setState(() {
        todos.add(Parametros(porta: '', ip: '').fromJson(todo));
      });
    }
  }

  /*
  Essa função é responsável por salvar na memoria todos os dados digitados na tela 'Novo servidor',
  assim como também realizar as alterações, os itens do vetor lista são encaminhos para a chave 'parametros'
  do sharedpreferences.
  */
  salvar_parametro() {
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('parametros', jsonEncode(items));
  }

  /*
  - Essa função é acionada quando o usuário clica no botão redondo de ' + ' na tela 'Servidores', 
  e o encaminhamento para a outra tela ocorre devido o 'Navigatir.push'.
  
  - Basicamente essa função adiciona um novo parametro na lista, primeiramente é adicionado um novo 'ip' e 'porta'
  na classe de modelo 'Parametros' e posteriormente os valores serão encaminhos para a lista global da classe,
  e exibidos na tela devido o setState().
  */
  adicionar_parametro() async {
    Parametros t = Parametros(ip: '', porta: '');
    Parametros returnList = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NovoServidor(parametros: t)));
    setState(() {
      todos.add(returnList);
    });
    salvar_parametro();
  }

  /*
  Essa função é acionada quando o usuário clica em algum dos Cards da lista e seleciona a opção
  'ALTERAR'.

  Basicamente a função chama o 'Navigator' para encaminhar pra tela 'Novo servidor', igual na 
  função de 'adicionar_parametro()' porém agora será passado como parâmetro o indice da lista correspondente 
  do card selecionado, fazendo assim com que ao carregar a tela 'Novo servidor' seja exibido os dados
  mostrados no Card que foi selecionado, podendo ser salvos novamente com novos valores.
  
  */
  alterar_parametro(int index) async {
    Parametros returnList = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NovoServidor(parametros: todos.elementAt(index))));

    salvar_parametro();
  }

  /*
  - Essa função é acionada quando o usuário clica no icone de lixeira dentro do Card, 
  em que será retornado na tela um Dialog que irá permitir a exclusão do Card do qual 
  foi selecionado a lixeira caso seja selecionado o button 'SIM',
  
  - A exclusão do Card ocorre devido o metodo 'remove' da lista porém ele apenas para de ser exibido na tela
  se tiver também a função 'salvar_parametros()' caso ela não fosse colocada o setState da tela
  mostraria o Card novamente ao mudar de tela e retornar para a tela 'Servidores'.
   */
  delete_parametro(Parametros todo) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Atenção",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              content: Text("Deseja realmente apagar ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              actions: [
                FlatButton(
                    onPressed: () {
                      setState(() {
                        todos.remove(todo);
                      });
                      Navigator.pop(ctx);
                      salvar_parametro();
                    },
                    child: Text("SIM",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400))),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("NÃO",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400))),
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    exibir_lista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          adicionar_parametro();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(223, 135, 4, 1),
        title: Text("Servidores",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400)),
      ),
      body: Container(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: prefs.getInt('indice') == index
                      ? Color.fromARGB(255, 255, 186, 83)
                      : Colors.white,
                  margin: EdgeInsets.all(5),
                  elevation: 10,
                  child: Container(
                    child: InkWell(
                      onTap: () async {
                        escolha_opcao(index);
                      },
                      child: conteudo_cards(todos[index], index),
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

  escolha_opcao(int indice) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Escolha uma opção",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
              actions: [
                FlatButton(
                  color: Color.fromARGB(255, 223, 135, 4),
                  onPressed: () {
                    alterar_parametro(indice);
                  },
                  child: Text(
                    'ALTERAR',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                FlatButton(
                    color: Color.fromARGB(255, 223, 135, 4),
                    onPressed: () async {
                      SharedValues value = SharedValues(indice);
                      var x = await value.exibirIp();
                      var y = await value.exibirPorta();

                      value.marcarPadrao(indice);
                      value.padraoLogin(x, y);
                      _navegaTelaLogin(context);
                    },
                    child: Text(
                      'SELECIONAR',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ));
  }

  /*Essa função é responsavel por chamar uma nova rota de widget(encaminhamento para uma nova página),
  a rota chamada será a classe apontada dentro da Arrow Function */
  _navegaTelaLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => tela_login()));
  }

  /*
  Essa função é responsável por carregar os conteúdos dentro do Card, 
  como o icone do número da lista, a informação do 'ip' e 'porta' e o icone da lixeira,
  sem essa função o Card é carregado porém não irá aparecer conteúdo nenhum.
  */
  conteudo_cards(Parametros todo, index) {
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
              delete_parametro(todo);
            },
            child: Icon(Icons.delete,
                color: Color.fromARGB(255, 223, 135, 4), size: 40.0)));
  }
}
