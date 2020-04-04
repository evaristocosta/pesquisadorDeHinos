import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/controlador.dart';

class Pesquisador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Página Principal', home: PesquisadorApp(), theme: estiloPadrao);
  }
}

class PesquisadorApp extends StatefulWidget {
  @override
  _PesquisadorAppState createState() => _PesquisadorAppState();
}

class _PesquisadorAppState extends State<PesquisadorApp> {
  bool notNull(Object o) => o != null;
  String textoPesquisa = '';
  bool pesquisando = true;

  bool fimAnimacao = false;

  void alternaWidget() {
    if (textoPesquisa.isEmpty) {
      setState(() {
        pesquisando = true;
        fimAnimacao = false;
      });
    } else {
      setState(() {
        pesquisando = false;
        fimAnimacao = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 400),
        child: Column(
          mainAxisAlignment:
              fimAnimacao ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            fimAnimacao
                ? null : Center(
                    child: Container(
                        width: 240,
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                        )),
                  ),

            Center(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 36,
                  child: Image(
                    image: AssetImage('assets/titulo.png'),
                  )),
            ),

            fimAnimacao
                ?  null : SizedBox(
                    height: 40,
                  ),

            Container(
              width: 320,
              child: TextField(
                onChanged: (texto) {
                  textoPesquisa = texto;
                  alternaWidget();
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


            fimAnimacao
                ? (pesquisando ? PrePesquisa() : ListagemDeHinos())
                : null,
            //SemResultados()
          ].where(notNull).toList(),
        ),
      )
          ),
    );
  }
}

class SemResultados extends StatelessWidget {
  const SemResultados({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
      ),
    );
  }
}

class PrePesquisa extends StatelessWidget {
  const PrePesquisa({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            height: 50,
          )
        ],
      ),
    );
  }
}

class ListagemDeHinos extends StatelessWidget {
  const ListagemDeHinos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, position) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Flex(
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
                        'titulo',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Text(
                        'categoria',
                        style: TextStyle(
                          color: RequisitaCor.requisitaCinza(30),
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text('parte do hino'),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'nº',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: RequisitaCor.requisitaAzul(20)),
                          ),
                          Text(
                            'XX',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                color: RequisitaCor.requisitaAzul(30),
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
                            color: RequisitaCor.requisitaAzul(30),
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 6),
                            child: Text(
                              'Coletanea',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 10,
                )
              ],
            ),
          );
        },
        itemCount: 2,
      ),
    );
  }
}
