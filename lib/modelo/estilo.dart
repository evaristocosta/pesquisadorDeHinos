import 'package:flutter/material.dart';

class CoresPadrao {
  CoresPadrao._();
  static const Map<int, Color> azul = const <int, Color>{
    10: const Color(0xFFB3C8DB),
    20: const Color(0xFF586D88),
    30: const Color(0xFF344D6B)
  };

  static const Map<int, Color> cinza = const <int, Color>{
    10: const Color(0xFFEEEEEE),
    20: const Color(0xFFDDDDDD),
    30: const Color(0xFF8D8D8D),
    40: const Color(0xFF373737)
  };
}

class EstiloPadrao {
  static ThemeData estilo = ThemeData(
      brightness: Brightness.light,
      primaryColor: CoresPadrao.azul[30],
      primaryColorBrightness: Brightness.light,
      accentColor: CoresPadrao.azul[20],
      accentColorBrightness: Brightness.light,
      backgroundColor: Colors.white,
      // fonte padrao
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline5: TextStyle(fontFamily: 'Oxanium'),
        headline6: TextStyle(fontFamily: 'Oxanium'),
        subtitle2: TextStyle(fontFamily: 'Raleway'),
        button: TextStyle(fontFamily: 'Raleway'),
      ),
      // outros
      splashColor: CoresPadrao.azul[30],
      buttonColor: CoresPadrao.azul[20],
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent));
}
