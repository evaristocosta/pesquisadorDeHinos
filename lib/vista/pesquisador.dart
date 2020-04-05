import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:pesquisadorhinos/controlador.dart';
import 'package:pesquisadorhinos/visualizador.dart';

class Pesquisador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Página Principal',
        home: SafeArea(child: PesquisadorApp()),
        theme: estiloPadrao);
  }
}

class PesquisadorApp extends StatefulWidget {
  @override
  _PesquisadorAppState createState() => _PesquisadorAppState();
}

class _PesquisadorAppState extends State<PesquisadorApp> {
  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(onShow: () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PesquisandoApp()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      image: AssetImage('assets/logo.png'),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 160,
                    child: Image(
                      image: AssetImage('assets/titulo.png'),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 320,
                child: TextField(
                  autofocus: false,
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
            ]),
      ),
    );
  }
}
