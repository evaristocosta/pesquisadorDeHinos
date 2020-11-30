import 'package:flutter/material.dart';

import 'package:pesquisadorhinos/controller/controlaSelecoes.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/components/carregando.dart';
import 'package:pesquisadorhinos/view/components/itemSelecao.dart';

class Subselecoes extends StatefulWidget {
  final String id;
  final String nome;
  const Subselecoes(this.id, this.nome);

  @override
  _SubselecoesState createState() => _SubselecoesState();
}

class _SubselecoesState extends State<Subselecoes> {
  ControlaSelecoes itens;
  bool _taCompleto = false;

  @override
  void initState() {
    itens = new ControlaSelecoes();
    itens.lidaComSelecao(widget.id).whenComplete(() {
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
        // https://stackoverflow.com/a/60528001
        title: Text(
            "${widget.nome[0].toUpperCase()}${widget.nome.substring(1).toLowerCase()}",
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
      ),
      body: SafeArea(
        child: _taCompleto
            ? itens.quantidadeSelecoes != 0
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemSelecao(
                        id: itens.selecoes[index].id,
                        tipo: itens.selecoes[index].tipo,
                        nome: itens.selecoes[index].nome,
                      );
                    },
                    itemCount: itens.quantidadeSelecoes,
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
