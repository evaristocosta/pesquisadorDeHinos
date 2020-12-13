import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/exibicaoLetra.dart';

class ItemHino extends StatelessWidget {
  final String nome;
  final String categoria;
  final String indicador;
  final String numero;
  final String coletanea;
  final String texto;

  const ItemHino({
    Key key,
    @required this.nome,
    @required this.categoria,
    @required this.indicador,
    @required this.numero,
    @required this.coletanea,
    @required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ExibicaoLetra()));
      },
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
                        nome,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Text(
                        categoria,
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
                          indicador,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: RequisitaEstilo.azul(20)),
                        ),
                        Text(
                          numero,
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
                            coletanea,
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
                  data: texto,
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
