import 'package:sqflite/sqflite.dart';
import 'package:validators/validators.dart';
import '../controlador.dart';

Future<List> pesquisaBD(String chave) async {
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

  await bd.close();
  return resultado;
}
