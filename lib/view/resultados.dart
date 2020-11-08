import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/view/components/itemHino.dart';

class Selecoes extends StatefulWidget {
  @override
  _SelecoesState createState() => _SelecoesState();
}

class _SelecoesState extends State<Selecoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Seleções e categorias',
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
      ),
      body: SafeArea(
        child: Expanded(
            child: ListView(
          children: [
            ItemHino(
                nome: null,
                categoria: null,
                indicador: null,
                numero: null,
                coletanea: null,
                texto: null)
          ],
        )),
      ),
    );
  }
}
