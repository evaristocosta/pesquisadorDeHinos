import 'package:sqflite/sqflite.dart';
import '../modelador.dart';

Future<List> pesquisaBD(String chave) async {
  var caminho = await conexaoBD();

  // open the database
  Database bd = await openDatabase(caminho, readOnly: true);

  var pesquisa = """
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
      numero LIKE \'$chave\' OR
      texto LIKE \'%$chave%\'
  """;

  print(pesquisa);

  List<Map> resultado = await bd.rawQuery(pesquisa);

  await bd.close();
  return resultado;
}
