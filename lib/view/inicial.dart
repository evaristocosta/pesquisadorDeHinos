import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// FirebaseAnalyticsObserver is still available from firebase_analytics.dart
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:pesquisadorhinos/controller/requisitaEstilos.dart';
import 'package:pesquisadorhinos/view/pesquisando.dart';
import 'package:pesquisadorhinos/view/selecoes.dart';
import 'package:pesquisadorhinos/view/sobre.dart';

class Pesquisador extends StatelessWidget {
  // Updated to use FirebaseAnalytics.instance
  static FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Página Principal',
      home: PesquisadorApp(),
      theme: RequisitaEstilo.tema(),
      navigatorObservers: [
        // FirebaseAnalyticsObserver constructor remains the same
        FirebaseAnalyticsObserver(analytics: _firebaseAnalytics)
      ],
    );
  }
}

class PesquisadorApp extends StatefulWidget {
  @override
  _PesquisadorAppState createState() => _PesquisadorAppState();
}

class _PesquisadorAppState extends State<PesquisadorApp> {
  // FirebaseMessaging instance is now accessed via FirebaseMessaging.instance
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Not needed as a field anymore for new API

  GlobalKey chaveBotao1 = GlobalKey();
  GlobalKey chaveBotao2 = GlobalKey();
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> alvos = List();

  void _depoisDeCarregar(_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _jaMostrouTutorial = (prefs.getBool('jaMostrouTutorial') ?? false);

    if (!_jaMostrouTutorial)
      Future.delayed(Duration(milliseconds: 100), () {
        mostraTutorial();
      });

    await prefs.setBool('jaMostrouTutorial', true);
  }

  void mostraTutorial() {
    tutorialCoachMark = TutorialCoachMark(context,
        targets: alvos, // List<TargetFocus>
        colorShadow: RequisitaEstilo.azul(30), // DEFAULT Colors.black
        alignSkip: Alignment.bottomLeft,
        textSkip: "PULAR",
        paddingFocus: 10,
        opacityShadow: 0.7, onFinish: () {
      print("finish");
    }, onClickTarget: (target) {
      print(target);
    }, onClickSkip: () {
      print("skip");
    })
      ..show();
  }

  void adicionaAlvos() {
    alvos.add(TargetFocus(
        identify: "Alvo 1",
        keyTarget: chaveBotao1,
        shape: ShapeLightFocus.Circle,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Column(
                children: [
                  Text(
                    'Opções e seleção de hinos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Aqui você tem acesso a diversas seleções e categorias de hinos selecionados e também informações sobre o aplicativo.",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ]));
    alvos.add(TargetFocus(
        identify: "Alvo 2",
        keyTarget: chaveBotao2,
        shape: ShapeLightFocus.RRect,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Column(
                children: [
                  Text(
                    'Pesquise o hino aqui!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Ao encontrar resultados, selecione o hino para ver sua letra.",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ]));
  }

  @override
  void initState() {
    adicionaAlvos();
    WidgetsBinding.instance.addPostFrameCallback(_depoisDeCarregar);
    super.initState();

    // New Firebase Messaging setup
    // Handle messages received while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Handle messages that opened the app from a background or terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.data}');
      // You can navigate to a specific screen based on message data here
    });

    // Request notification permissions
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Get FCM token
    FirebaseMessaging.instance.getToken().then((token) {
      print('FCM Token: $token');
    });
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

  List<SpeedDialChild> _pegaMenu() {
    List<SpeedDialChild> itens = [];

    itens.add(_padraoBotaoDeMenu(
        iconData: Icons.info_outline,
        texto: 'Informações',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Sobre(),
                  settings: RouteSettings(name: 'Sobre')));
        }));
    itens.add(_padraoBotaoDeMenu(
        iconData: Icons.list,
        texto: 'Seleções e categorias',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Selecoes(),
                  settings: RouteSettings(name: 'Selecoes')));
        }));

    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        child: Container(key: chaveBotao1, child: Icon(Icons.menu)),
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
                        image: AssetImage('assets/images/logo.png'),
                      )),
                ),
                Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: 160,
                      child: Image(
                        image: AssetImage('assets/images/marca.png'),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  key: chaveBotao2,
                  width: 320,
                  child: TextField(
                    autofocus: false,
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PesquisandoApp(),
                                settings:
                                    RouteSettings(name: 'Realizar pesquisa')));
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
