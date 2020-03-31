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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 36,
                  child: Image(
                    image: AssetImage('assets/titulo.png'),
                  )),
            ),
            Container(
              width: 320,
              child: TextField(
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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                            Text('coletanea')
                          ],
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
            )
          ],
        ),
      ),

      /* 
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
              width: 240,
              child: Image(
                image: AssetImage('assets/logo.png'),
              )),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          width: 320,
          child: TextField(
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
      ],
    ) */
    );
  }
}
