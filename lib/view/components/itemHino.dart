import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pesquisadorhinos/controller/controlaPesquisa.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';

class ItemHino extends StatelessWidget {
  const ItemHino({
    Key key,
    @required this.pesquisador,
    @required this.indice,
  }) : super(key: key);

  final ControlaPesquisa pesquisador;
  final int indice;

  @override
  Widget build(BuildContext context) {
    var hino = pesquisador.hinos[indice];

    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        hino.nome,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Text(
                        hino.categoria,
                        style: TextStyle(
                            color: RequisitaEstilo.cinza(30),
                            fontFamily: 'Raleway',
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          hino.indicador,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: RequisitaEstilo.azul(20)),
                        ),
                        Text(
                          (hino.numero?.toString()) ?? '',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: RequisitaEstilo.azul(30),
                              fontSize: 20),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Container(
                          color: RequisitaEstilo.azul(30),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                          child: Text(
                            hino.coletanea,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                    )
                  ],
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 8),
                child: Html(
                  data: hino.texto,
                )),
            Divider(
              color: RequisitaEstilo.cinza(40),
            ),
          ],
        ),
      ),
    );
  }
}
