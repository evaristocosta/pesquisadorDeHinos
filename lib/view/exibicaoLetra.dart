import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';

class ExibicaoLetra extends StatefulWidget {
  @override
  _ExibicaoLetraState createState() => _ExibicaoLetraState();
}

class _ExibicaoLetraState extends State<ExibicaoLetra> {
  String nome = 'O SANGUE DE JESUS TEM PODER';
  String categoria = 'CLAMOR';
  String indicador = 'nº';
  String numero = '1';
  String coletanea = 'COLETÂNEA';
  String texto = """
    O SANGUE DE JESUS TEM PODER,<br />
    PODER QUE A MIM PODE VALER,<br />
    SE COMUNHÃO NÃO POSSO EU SENTIR, <br />
    SENHOR,DERRAMA DO TEU SANGUE REMIDOR.<br />
    <br />
    <b>CORO</b><br />
    DERRAMA DO TEU SANGUE SOBRE MIM, Ó SENHOR,<br />
    DERRAMA DO TEU SANGUE SOBRE MIM, Ó SENHOR,<br />
    SEI QUE ESTÁS AQUI E ISTO QUERO EU SENTIR,<br />
    DERRAMA DO TEU SANGUE SOBRE MIM.<br />
    <br />
    EM TUA PRESENÇA ESTOU, SENHOR,<br />
    DE TI NECESSITO MUITO AMOR,<br />
    PELO PODER QUE HÁ EM TEU SANGUE REMIDOR,<br />
    Ó VEM PURIFICAR-ME, MEU SENHOR.<br />
    <br />
    <b>CORO</b><br />
    DERRAMA DO TEU SANGUE SOBRE MIM, Ó SENHOR,<br />
    DERRAMA DO TEU SANGUE SOBRE MIM, Ó SENHOR,<br />
    SEI QUE ESTÁS AQUI E ISTO QUERO EU SENTIR,<br />
    DERRAMA DO TEU SANGUE SOBRE MIM.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                          indicador + ' ',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: RequisitaEstilo.azul(20)),
                        ),
                        Text(
                          numero,
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
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                          child: Text(
                            coletanea,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                    )
                  ],
                ),
              ),
              Text(
                categoria,
                style: TextStyle(
                    color: RequisitaEstilo.cinza(30),
                    fontFamily: 'Raleway',
                    fontSize: 12),
              ),
              Text(
                nome,
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
                data: texto,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
