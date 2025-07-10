import 'package:flutter/material.dart';

import 'package:pesquisadorhinos/model/Estilo.dart';

class RequisitaEstilo {
  static Color cinza(int _cor) {
    return CoresPadrao.cinza[_cor] ?? Colors.grey;
  }

  static Color azul(int _cor) {
    return CoresPadrao.azul[_cor] ?? Colors.blue;
  }

  static ThemeData tema() {
    return EstiloPadrao.estilo;
  }
}
