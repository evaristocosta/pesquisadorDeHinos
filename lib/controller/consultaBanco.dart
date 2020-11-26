import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'conectaBancoDeDados.dart';

class ConsultaBanco {
  pesquisa(String pesquisa) async {
    var caminho = await conectaBancoDeDados();

    // open the database
    Database bd = await openDatabase(caminho, readOnly: true);
    var resposta = await bd.rawQuery(pesquisa);

    await bd.close();

    return jsonEncode(resposta);
  }
}
