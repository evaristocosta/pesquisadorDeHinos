import 'package:pesquisadorhinos/model/Hino.dart';
import 'package:pesquisadorhinos/controller/processaHinos.dart';

class ControlaExibicaoTexto {
  List<Hino> hinos;
  ProcessaHinos processaHinos;

  busca(int idhinos) async {
    processaHinos = new ProcessaHinos();
    var pesquisa;

    pesquisa = """
        SELECT 
          idhinos,
          numero,
          nome,
          texto,
          categoria,
          coletanea
        FROM 
          hinos
        WHERE
          idhinos=$idhinos 
      """;

    hinos = await processaHinos.preencher(pesquisa, true);
  }
}
