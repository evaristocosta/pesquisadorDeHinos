import 'package:pesquisadorhinos/controller/consultaBanco.dart';
import 'package:pesquisadorhinos/model/Hino.dart';

class ControlaResultadosSelecoes {
  List<Hino> hinos;
  ConsultaBanco consultaBanco;

  int get quantidadeHinos {
    return hinos?.length ?? 0;
  }

  buscaTemaLetraOuColetanea(String id, String busca) async {
    consultaBanco = new ConsultaBanco();
    var coluna;

    switch (id) {
      case 'tema':
        coluna = 'categoria';
        break;

      case 'alfabeto':
        coluna = 'texto';
        break;

      case 'coletanea':
        coluna = 'coletanea';
        break;
    }

    var pesquisa = """
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
          $coluna LIKE \'$busca%\' 
      """;

    try {
      var resposta = await consultaBanco.pesquisa(pesquisa);
      hinos = hinoFromJson(resposta);

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
  }
}
