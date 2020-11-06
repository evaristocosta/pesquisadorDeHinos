import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:pesquisadorhinos/controle/requisitaEstilos.dart';
import 'package:pesquisadorhinos/vista/pesquisando.dart';
import 'package:pesquisadorhinos/vista/sobre.dart';

class Pesquisador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        title: 'Página Principal',
        home: PesquisadorApp(),
        theme: RequisitaEstilo.tema());
  }
}

class PesquisadorApp extends StatefulWidget {
  @override
  _PesquisadorAppState createState() => _PesquisadorAppState();
}

class _PesquisadorAppState extends State<PesquisadorApp> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

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
          color: RequisitaEstilo.azul(30),
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
