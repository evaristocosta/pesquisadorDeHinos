import 'package:flutter/material.dart';
import '../modelador.dart';

class RequisitaEstilo {
  static Color cinza(int _cor) {
    return CoresPadrao.cinza[_cor];
  }

  static Color azul(int _cor) {
    return CoresPadrao.azul[_cor];
  }

  static ThemeData tema() {
    return EstiloPadrao.estilo;
  }
}
