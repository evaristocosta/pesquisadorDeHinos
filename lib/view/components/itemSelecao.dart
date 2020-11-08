import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';

class ItemSelecao extends StatelessWidget {
  final String titulo;
  final String descricao;

  const ItemSelecao({
    Key key,
    @required this.titulo,
    this.descricao,
  }) : super(key: key);

  List<Widget> _temDescricao() {
    List<Widget> conteudo = [
      Text(
        titulo,
        style: TextStyle(fontFamily: 'Raleway', fontSize: 22),
      )
    ];

    if (descricao == null) {
      conteudo.add(Container());
    } else {
      conteudo.addAll([
        SizedBox(
          height: 13,
        ),
        Text(descricao)
      ]);
    }
    return conteudo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: RequisitaEstilo.cinza(20),
                  offset: Offset(4, 4),
                  blurRadius: 8)
            ],
            border: Border.all(color: RequisitaEstilo.cinza(20)),
            borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _temDescricao()),
          ),
        ),
      ),
    );
  }
}
