import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/controlador.dart';
import 'package:validators/validators.dart';
import 'package:flutter_html/flutter_html.dart';

class PesquisandoApp extends StatefulWidget {
  @override
  _PesquisandoAppState createState() => _PesquisandoAppState();
}

class _PesquisandoAppState extends State<PesquisandoApp> {
  bool notNull(Object o) => o != null;
  String textoPesquisa = '';
  bool pesquisando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 160,
                    child: Image(
                      image: AssetImage('assets/titulo.png'),
                    )),
              ),
              Container(
                width: 320,
                child: TextField(
                  autofocus: true,
                  onChanged: (texto) {
                    if (texto.isNotEmpty &&
                        (isInt(texto) || texto.length >= 3)) {
                      textoPesquisa = texto.toUpperCase();
                      setState(() {
                        pesquisando = true;
                      });
                    } else {
                      setState(() {
                        pesquisando = false;
                      });
                    }
                  },
                  cursorColor: RequisitaCor.requisitaCinza(40),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 22),
              width: 180,
              child: Image(
                image: AssetImage('assets/prePesquisa.png'),
              )),
          Text(
            'Comece a pesquisar...',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 24,
                color: RequisitaCor.requisitaCinza(30)),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Digite ao menos 3 letras ou 1 dígito numérico")
        ],
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

                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
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
                                          _item["nome"],
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'Raleway',
                                          ),
                                        ),
                                        Text(
                                          _item['categoria'],
                                          style: TextStyle(
                                            color:
                                                RequisitaCor.requisitaCinza(30),
                                            fontFamily: 'Raleway',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'nº ',
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                color:
                                                    RequisitaCor.requisitaAzul(
                                                        20)),
                                          ),
                                          Text(
                                            _item["numero"].toString(),
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                color:
                                                    RequisitaCor.requisitaAzul(
                                                        30),
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
                                            color:
                                                RequisitaCor.requisitaAzul(30),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 6),
                                            child: Text(
                                              _item['coletanea'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Html(
                                    data: (_item["texto"] as String)
                                        .replaceAll("\\n\\n", "\\n").replaceAll("\\n", "<br>")),
                              )
                            ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 22),
            width: 180,
            child: Image(
              image: AssetImage('assets/semAchar.png'),
            )),
        Text(
          'Nenhum hino encontrado',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              color: RequisitaCor.requisitaCinza(30)),
        ),
        SizedBox(
          height: 50,
        )
      ],
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
              image: AssetImage('assets/semAchar.png'),
            )),
        Text(
          'Ops! Algo deu errado...',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              color: RequisitaCor.requisitaCinza(30)),
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
