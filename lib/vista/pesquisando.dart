import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/controlador.dart';

class PesquisandoApp extends StatefulWidget {
  @override
  _PesquisandoAppState createState() => _PesquisandoAppState();
}

class _PesquisandoAppState extends State<PesquisandoApp> {
  bool notNull(Object o) => o != null;
  String textoPesquisa = '';
  bool pesquisando = true;

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
                    textoPesquisa = texto;
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

              pesquisando ? prePesquisa() : listaDeHinos(),
              //semResultados()
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
            height: 50,
          )
        ],
      ),
    );
  }

  Expanded listaDeHinos() {
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

  Widget semResultados() {
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
