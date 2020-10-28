import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_html/flutter_html.dart';
import '../controlador.dart';

class PesquisandoApp extends StatefulWidget {
  @override
  _PesquisandoAppState createState() => _PesquisandoAppState();
}

class _PesquisandoAppState extends State<PesquisandoApp> {
  bool notNull(Object o) => o != null;
  String textoPesquisa = '';
  bool pesquisando = false;

  final _debouncer = Debouncer(milliseconds: 800);

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
                    _debouncer.run(() {
                      if (texto.isNotEmpty &&
                          (isInt(texto) || texto.length >= 3)) {
                        setState(() => pesquisando = true);
                        textoPesquisa = texto.toUpperCase();
                        print(textoPesquisa);
                      } else {
                        setState(() => pesquisando = false);
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
              pesquisando ? listaDeHinos(textoPesquisa) : prePesquisa(),
            ].where(notNull).toList(),
          ),
        ),
      ),
    );
  }

  Expanded prePesquisa() {
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
                  image: AssetImage('assets/imgs/prePesquisa.png'),
                )),
            Text(
              'Comece a pesquisar...',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 24,
                  color: RequisitaEstilo.cinza(30)),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Digite ao menos 3 letras ou 1 dígito numérico")
          ],
        ),
      ),
    );
  }

  Expanded listaDeHinos(String chave) {
    return Expanded(
      child: FutureBuilder(
        future: pesquisaBD(chave),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return erro(snapshot.error);
            } else {
              List<Map> _lista = snapshot.data;

              return _lista.length > 0
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        final _item = _lista[index];

                        final _numero = _item["numero"];
                        final _indicador = _numero == null ? 's/n' : 'nº ';
                        final _nome = _item["nome"];
                        final _categoria = _item['categoria'];
                        final _coletanea = _item['coletanea'];
                        final _texto = (_item["texto"] as String)
                            .replaceAll("\\n\\n", "\\n")
                            .replaceAll("\\n", " ");

                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _nome ?? '',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          Text(
                                            _categoria ?? '',
                                            style: TextStyle(
                                                color:
                                                    RequisitaEstilo.cinza(30),
                                                fontFamily: 'Raleway',
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              _indicador,
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  color:
                                                      RequisitaEstilo.azul(20)),
                                            ),
                                            Text(
                                              (_numero?.toString()) ?? '',
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  color:
                                                      RequisitaEstilo.azul(30),
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
                                                _coletanea ?? '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 8),
                                    child: Html(
                                      data: _texto,
                                    )),
                                Divider(
                                  color: RequisitaEstilo.cinza(40),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _lista.length,
                    )
                  : semResultados();
            }
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 75.0,
                width: 75.0,
              ),
            );
          }
        },
      ),
    );
  }

  Widget semResultados() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 22),
              width: 180,
              child: Image(
                image: AssetImage('assets/imgs/semAchar.png'),
              )),
          Text(
            'Nenhum hino encontrado',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 24,
                color: RequisitaEstilo.cinza(30)),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget erro(String erro) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 22),
            width: 180,
            child: Image(
              image: AssetImage('assets/imgs/semAchar.png'),
            )),
        Text(
          'Ops! Algo deu errado...',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              color: RequisitaEstilo.cinza(30)),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Contate o desenvolvedor para solucionar o problema."),
        Text('Erro: $erro'),
      ],
    );
  }
}
