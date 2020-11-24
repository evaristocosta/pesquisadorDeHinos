import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:validators/validators.dart';

import 'conectaBancoDeDados.dart';
import 'package:pesquisadorhinos/model/Hino.dart';

class ControlaPesquisa {
  List<Hino> hinos;

  int get quantidadeHinos {
    return hinos.length;
  }

  realizaPesquisa(String chave) async {
    var caminho = await conectaBancoDeDados();
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
          categoria LIKE \'%$chave%\' OR 
          coletanea LIKE \'%$chave%\' OR 
          texto LIKE \'%$chave%\'
      """;

    try {
      hinos = hinoFromJson(jsonEncode(await bd.rawQuery(pesquisa)));

      hinos.forEach((hino) {
        hino.nome = hino.nome ?? '';
        hino.categoria = hino.categoria ?? '';
        hino.coletanea = hino.coletanea ?? '';
        hino.indicador = hino.numero == null ? 's/n' : 'nº ';
        hino.texto =
            (hino.texto).replaceAll("\\n\\n", "\\n").replaceAll("\\n", " ");
      });
    } catch (e) {
      print(e);
    }

    await bd.close();
  }
}
