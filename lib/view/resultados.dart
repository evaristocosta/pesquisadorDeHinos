import 'package:flutter/material.dart';

import 'package:pesquisadorhinos/controller/controlaResultadosSelecoes.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/components/carregando.dart';
import 'package:pesquisadorhinos/view/components/itemHino.dart';

class Resultados extends StatefulWidget {
  final String id;
  final String nome;
  const Resultados(this.id, this.nome);

  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  ControlaResultadosSelecoes itens;
  bool _taCompleto = false;

  @override
  void initState() {
    itens = new ControlaResultadosSelecoes();
    itens.busca(widget.id, widget.nome).whenComplete(() {
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
        title: Text(
            "${widget.nome[0].toUpperCase()}${widget.nome.substring(1).toLowerCase()}",
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
      ),
      body: SafeArea(
        child: _taCompleto
            ? itens.quantidadeHinos != 0
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemHino(
                          idhinos: itens.hinos[index].idhinos,
                          nome: itens.hinos[index].nome,
                          categoria: itens.hinos[index].categoria,
                          indicador: itens.hinos[index].indicador,
                          numero: itens.hinos[index].numero?.toString() ?? '',
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
            : Carregando(),
      ),
    );
  }
}
