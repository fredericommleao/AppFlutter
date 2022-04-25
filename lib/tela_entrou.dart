// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Entrou extends StatefulWidget {
  @override
  State<Entrou> createState() => _EntrouState();
}

class _EntrouState extends State<Entrou> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Text(
          'Entrou',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
