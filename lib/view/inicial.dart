import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/pesquisando.dart';
import 'package:pesquisadorhinos/view/sobre.dart';

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
      // ignore: missing_return
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      // ignore: missing_return
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

  List<SpeedDialChild> _pegaMenu() {
    List<SpeedDialChild> itens = [];

    itens.add(_padraoBotaoDeMenu(
        iconData: Icons.info_outline,
        texto: 'Informações',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Sobre()));
        }));
    itens.add(_padraoBotaoDeMenu(
        iconData: Icons.list,
        texto: 'Seleções e categorias',
        onPressed: () {
          print('list');
        }));

    return itens;
  }

  SpeedDialChild _padraoBotaoDeMenu(
      {IconData iconData, Function onPressed, String texto}) {
    return SpeedDialChild(
        backgroundColor: Colors.white,
        child: Icon(
          iconData,
          color: RequisitaEstilo.azul(30),
        ),
        onTap: onPressed,
        labelWidget: Text(
          texto,
          style: TextStyle(
            color: RequisitaEstilo.azul(30),
            fontSize: 18,
            fontFamily: 'Raleway',
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: _pegaMenu(),
        overlayColor: Colors.white,
        overlayOpacity: 0.8,
        backgroundColor: Colors.white,
        foregroundColor: RequisitaEstilo.azul(30),
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
