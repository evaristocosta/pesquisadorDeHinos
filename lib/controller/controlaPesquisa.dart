import 'package:validators/validators.dart';

import 'package:pesquisadorhinos/model/Hino.dart';
import 'package:pesquisadorhinos/controller/processaHinos.dart';

class ControlaPesquisa {
  List<Hino> hinos;
  ProcessaHinos processaHinos;

  int get quantidadeHinos {
    return hinos.length;
  }

  busca(String chave) async {
    processaHinos = new ProcessaHinos();
    var pesquisa;

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

    hinos = await processaHinos.preencher(pesquisa, false);
  }
}
