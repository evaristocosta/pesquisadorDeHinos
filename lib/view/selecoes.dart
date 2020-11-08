import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/view/components/itemSelecao.dart';

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
            ItemSelecao(
              titulo: 'SELEÇÃO POR TEMA',
              descricao:
                  'Louvores organizados pelos temas da coletânea (clamor, dedicação, etc.)',
            ),
            ItemSelecao(
              titulo: 'SELEÇÃO POR TEMA',
            ),
            ItemSelecao(
              titulo: 'SELEÇÃO POR TEMA',
            ),
          ],
        )),
      ),
    );
  }
}
