import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import 'package:pesquisadorhinos/view/components/carregando.dart';
import 'package:pesquisadorhinos/view/components/itemHino.dart';
import 'package:pesquisadorhinos/controller/debouncer.dart';
import 'package:pesquisadorhinos/controller/controlaPesquisa.dart';
import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';

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
            ? Carregando()
            : pesquisador.quantidadeHinos == 0
                ? informativo(semResultados)
                : resultadosPesquisa());
  }

  Widget resultadosPesquisa() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ItemHino(
            nome: pesquisador.hinos[index].nome,
            categoria: pesquisador.hinos[index].categoria,
            indicador: pesquisador.hinos[index].indicador,
            numero: pesquisador.hinos[index].numero?.toString() ?? '',
            coletanea: pesquisador.hinos[index].coletanea,
            texto: pesquisador.hinos[index].texto,
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
