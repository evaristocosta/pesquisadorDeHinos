import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/components/itemHino.dart';

class Resultados extends StatefulWidget {
  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  @override
  Widget build(BuildContext context) {
    int quantidadeResultados = 0;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Resultados',
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
      ),
      body: SafeArea(
        child: Expanded(
            child: quantidadeResultados != 0
                ? ListView(
                    children: [
                      ItemHino(
                          nome: '',
                          categoria: '',
                          indicador: '',
                          numero: '',
                          coletanea: '',
                          texto: '')
                    ],
                  )
                : Center(
                    child: Text(
                    'Nenhum item encontrado',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 24,
                        color: RequisitaEstilo.cinza(30)),
                  ))),
      ),
    );
  }
}
