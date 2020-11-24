import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/controller/controlaSelecoes.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/components/itemHino.dart';

class Resultados extends StatefulWidget {
  final String letra;
  const Resultados(this.letra);

  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  ControlaSelecoes itens;
  bool _taCompleto = false;

  @override
  void initState() {
    itens = new ControlaSelecoes();
    itens.buscaAlfabeto(widget.letra).whenComplete(() {
      setState(() => _taCompleto = true);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Resultados',
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
      ),
      body: SafeArea(
        child: Expanded(
            child: _taCompleto
                ? itens.quantidadeHinos != 0
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return ItemHino(
                              nome: itens.hinos[index].nome,
                              categoria: itens.hinos[index].categoria,
                              indicador: itens.hinos[index].indicador,
                              numero:
                                  itens.hinos[index].numero?.toString() ?? '',
                              coletanea: itens.hinos[index].coletanea,
                              texto: itens.hinos[index].texto);
                        },
                        itemCount: itens.quantidadeHinos,
                      )
                    : Center(
                        child: Text(
                        'Nenhum item encontrado',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 24,
                            color: RequisitaEstilo.cinza(30)),
                      ))
                : Container(
                    child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 75.0,
                      width: 75.0,
                    ),
                  ))),
      ),
    );
  }
}
