import 'package:flutter/material.dart';
import 'package:pesquisadorhinos/modelador.dart';

final TextTheme fontesPadrao = TextTheme(
  headline: TextStyle(fontFamily: 'Oxanium'),
  title: TextStyle(fontFamily: 'Oxanium'),
  subtitle: TextStyle(fontFamily: 'Raleway'),
  button: TextStyle(fontFamily: 'Raleway'),
);

final ThemeData estiloPadrao = ThemeData(
    // padrao de cores
    brightness: Brightness.light,
    primaryColor: CoresPadrao.azul[30],
    primaryColorBrightness: Brightness.light,
    accentColor: CoresPadrao.azul[20],
    accentColorBrightness: Brightness.light,
    backgroundColor: Colors.white,
    // fonte padrao
    fontFamily: 'Roboto',
    textTheme: fontesPadrao,
    // outros
    splashColor: CoresPadrao.azul[30],
    buttonColor: CoresPadrao.azul[20],
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent));

class RequisitaCor {
  static Color requisitaCinza(int _cor) {
    return CoresPadrao.cinza[_cor];
  } 

  static Color requisitaAzul(int _cor) {
    return CoresPadrao.azul[_cor];
  } 
}