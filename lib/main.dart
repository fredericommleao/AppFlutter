// ignore_for_file: avoid_print, prefer_const_constructors, avoid_unnecessary_containers
import 'package:aplicativo/Parametros_sistema.dart';
import 'package:aplicativo/pagina_depois_login.dart';
import 'package:aplicativo/requisicao_post_http.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'APP SOCIAL';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController ipController = TextEditingController();

  final TextEditingController portaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                height: 30,
                color: Colors.orange,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Parâmetros do sistema'),
                  onPressed: () {
                    _navegaParametros(context);
                  },
                )),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1),
            ),
            Container(
              child: OutlinedButton(
                onPressed: () {},
                child: Text('GalleryLocalizations.of(context).buttonText'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (nameController.text == 'SUP' &&
                        passwordController.text == '75E%#NLMjbeVt') {
                      loginAPI.login(
                          nameController.text, passwordController.text);
                      _navegaHomepage(context);
                    } else {
                      print('nao entrou');
                    }
                  },
                )),
          ],
        ));
  }
}

_navegaParametros(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Parametros()));
}

_navegaHomepage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => entrou()));
}
