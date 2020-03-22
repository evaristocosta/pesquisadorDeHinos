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
    ));
  }
}
