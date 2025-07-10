import 'package:flutter/material.dart';

import 'package:pesquisadorhinos/controller/controlaSelecoes.dart';
import 'package:pesquisadorhinos/view/components/itemSelecao.dart';

class Selecoes extends StatefulWidget {
  @override
  _SelecoesState createState() => _SelecoesState();
}

class _SelecoesState extends State<Selecoes> {
  late ControlaSelecoes itens;

  @override
  void initState() {
    itens = new ControlaSelecoes();
    itens.listaSelecoes();
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
        title: Text('Seleções e categorias',
            style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ItemSelecao(
                tipo: itens.selecoes[index].tipo ?? 0,
                id: itens.selecoes[index].id ?? '',
                nome: itens.selecoes[index].nome ?? '',
                descricao: itens.selecoes[index].descricao);
          },
          itemCount: itens.quantidadeSelecoes,
        ),
      ),
    );
  }
}
