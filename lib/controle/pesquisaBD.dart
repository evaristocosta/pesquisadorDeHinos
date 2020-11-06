import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:validators/validators.dart';

import 'conexaoBD.dart';
import 'package:pesquisadorhinos/modelo/hino.dart';

class PesquisaBD {
  List<Hino> hinos;

  int get quantidadeHinos {
    return hinos.length;
  }

  Future<bool> realizaPesquisa(String chave) async {
    var caminho = await conexaoBD();
    var pesquisa;

    // open the database
    Database bd = await openDatabase(caminho, readOnly: true);

    isInt(chave)
        ? pesquisa = """
        SELECT 
          idhinos,
          numero,
          nome,
          SUBSTR(texto, 1, 70) || '...' texto,
          categoria,
          coletanea
        FROM 
          hinos
        WHERE
          numero LIKE \'$chave\' 
      """
        : pesquisa = """
        SELECT 
          idhinos,
          numero,
          nome,
          CASE
            WHEN INSTR(texto, \'$chave\') > 10 THEN
              '...' || SUBSTR(texto, INSTR(texto, \'$chave\') - 10, 70) || '...' 
            ELSE
              SUBSTR(texto, 1, 70) || '...' 
            END texto,
          categoria,
          coletanea
        FROM 
          hinos
        WHERE
          nome LIKE \'%$chave%\' OR 
          texto LIKE \'%$chave%\'
      """;

    List<Map> resultado = await bd.rawQuery(pesquisa);
    hinos = hinoFromJson(jsonEncode(resultado));

    await bd.close();
    return true;
  }
}
