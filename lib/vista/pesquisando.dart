import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:pesquisadorhinos/controle/debouncer.dart';
import 'package:pesquisadorhinos/controle/controlaPesquisa.dart';
import 'package:pesquisadorhinos/controle/requisitaEstilos.dart';

class PesquisandoApp extends StatefulWidget {
  @override
  _PesquisandoAppState createState() => _PesquisandoAppState();
}

class _PesquisandoAppState extends State<PesquisandoApp> {
  bool notNull(Object o) => o != null;
  final debouncer = Debouncer(milliseconds: 400);

  ControlaPesquisa pesquisador;

  bool taPesquisando = false;
  bool taCarregando = true;
  var prePesquisa = {
    'img': 'assets/imgs/prePesquisa.png',
    'titulo': 'Comece a pesquisar...',
    'subtitulo': 'Digite ao menos 3 letras ou 1 dígito numérico'
  };
  var semResultados = {
    'img': 'assets/imgs/semAchar.png',
    'titulo': 'Nenhum hino encontrado',
    'subtitulo': '',
  };

  @override
  void initState() {
    pesquisador = new ControlaPesquisa();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    margin: EdgeInsets.only(top: 26),
                    width: 160,
                    child: Image(
                      image: AssetImage('assets/imgs/marca.png'),
                    )),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: TextField(
                  autofocus: true,
                  onChanged: (texto) {
                    debouncer.run(() async {
                      if (texto.isNotEmpty &&
                          (isInt(texto) || texto.length >= 3)) {
                        setState(() {
                          taPesquisando = true;
                          taCarregando = true;
                        });

                        await pesquisador.realizaPesquisa(texto.toUpperCase());

                        setState(() => taCarregando = false);
                      } else {
                        setState(() => taPesquisando = false);
                      }
                    });
                  },
                  cursorColor: RequisitaEstilo.cinza(40),
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 0.0,
                          )),
                      contentPadding: EdgeInsets.symmetric(horizontal: 24)),
                ),
              ),
              taPesquisando ? carregandoPesquisa() : informativo(prePesquisa),
            ].where(notNull).toList(),
          ),
        ),
      ),
    );
  }

  Widget carregandoPesquisa() {
    return Container(
        child: taCarregando
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 75.0,
                  width: 75.0,
                ),
              )
            : pesquisador.quantidadeHinos == 0
                ? informativo(semResultados)
                : resultadosPesquisa());
  }

  Widget resultadosPesquisa() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final hino = pesquisador.hinos[index];

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
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                child: Text(
                                  hino.coletanea,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
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
        },
        itemCount: pesquisador.quantidadeHinos,
      ),
    );
  }

  Widget informativo(Map<String, String> textos) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 22),
                width: 180,
                child: Image(
                  image: AssetImage(textos['img']),
                )),
            Text(
              textos['titulo'],
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 24,
                  color: RequisitaEstilo.cinza(30)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(textos['subtitulo'])
          ],
        ),
      ),
    );
  }
}
