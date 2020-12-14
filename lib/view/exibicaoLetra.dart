import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pesquisadorhinos/controller/controlaExibicaoTexto.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/components/carregando.dart';

class ExibicaoLetra extends StatefulWidget {
  final int idhinos;
  const ExibicaoLetra(this.idhinos);

  @override
  _ExibicaoLetraState createState() => _ExibicaoLetraState();
}

class _ExibicaoLetraState extends State<ExibicaoLetra> {
  ControlaExibicaoTexto pesquisador;
  bool _taCompleto = false;
  double _tamanhoTexto = 14.0;

  @override
  void initState() {
    pesquisador = new ControlaExibicaoTexto();
    pesquisador.busca(widget.idhinos).whenComplete(() {
      setState(() => _taCompleto = true);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _aumentaTexto() {
    setState(() {
      if (_tamanhoTexto <= 30.0) _tamanhoTexto += 1.0;
    });
  }

  void _diminuiTexto() {
    setState(() {
      if (_tamanhoTexto >= 10.0) _tamanhoTexto -= 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _diminuiTexto(),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.remove,
              color: RequisitaEstilo.azul(30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _aumentaTexto(),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: RequisitaEstilo.azul(30),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _taCompleto
            ? SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  pesquisador.hinos[0].indicador + ' ',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      color: RequisitaEstilo.azul(20)),
                                ),
                                Text(
                                  pesquisador.hinos[0].numero?.toString() ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      color: RequisitaEstilo.azul(30),
                                      fontSize: 24),
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 6),
                                  child: Text(
                                    pesquisador.hinos[0].coletanea,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Text(
                        pesquisador.hinos[0].categoria,
                        style: TextStyle(
                            color: RequisitaEstilo.cinza(30),
                            fontFamily: 'Raleway',
                            fontSize: 12),
                      ),
                      Text(
                        pesquisador.hinos[0].nome,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: Divider(
                          color: RequisitaEstilo.cinza(40),
                        ),
                      ),
                      Html(
                        data: pesquisador.hinos[0].texto,
                        defaultTextStyle:
                            TextStyle(fontSize: _tamanhoTexto, height: 1.4),
                      ),
                    ],
                  ),
                ),
              )
            : Carregando(),
      ),
    );
  }
}
