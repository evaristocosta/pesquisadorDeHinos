import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pesquisadorhinos/controlador.dart';
import 'package:pesquisadorhinos/visualizador.dart';

class Pesquisador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Sobre()));
        },
        child: Icon(
          Icons.info_outline,
          color: RequisitaCor.requisitaAzul(30),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      width: 180,
                      child: Image(
                        image: AssetImage('assets/imgs/logo.png'),
                      )),
                ),
                Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: 160,
                      child: Image(
                        image: AssetImage('assets/imgs/marca.png'),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 320,
                  child: TextField(
                    autofocus: false,
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PesquisandoApp()));
                      });
                    },
                    readOnly: true,
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
              ]),
        ),
      ),
    );
  }
}
