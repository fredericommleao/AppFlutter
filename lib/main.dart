// ignore_for_file: avoid_print, prefer_const_constructors, avoid_unnecessary_containers
import 'package:aplicativo/tela_autenticacao.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Autenticacao(),
    );
  }
}
