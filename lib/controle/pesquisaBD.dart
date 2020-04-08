import 'package:sqflite/sqflite.dart';
import '../modelador.dart';

void pesquisaBD(String chave) async {
  var caminho = await conexaoBD();

  // open the database
  Database bd = await openDatabase(caminho, readOnly: true);

  List<Map> resultado = await bd.rawQuery("""
    SELECT * FROM hinos WHERE 
      nome LIKE \'%$chave%\' OR 
      numero LIKE \'%$chave%\' OR 
      texto LIKE \'%$chave%\'
    """);
  print(resultado);

  await bd.close();
}
