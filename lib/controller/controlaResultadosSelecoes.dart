import 'package:pesquisadorhinos/controller/consultaBanco.dart';
import 'package:pesquisadorhinos/model/Hino.dart';

class ControlaResultadosSelecoes {
  List<Hino> hinos;
  ConsultaBanco consultaBanco;

  int get quantidadeHinos {
    return hinos?.length ?? 0;
  }

  buscaTema(String tema) async {
    consultaBanco = new ConsultaBanco();

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
          categoria LIKE \'$tema\' 
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

  buscaAlfabeto(String letra) async {
    consultaBanco = new ConsultaBanco();

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
          texto LIKE \'$letra%\' 
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

  buscaColetanea(String coletanea) async {
    consultaBanco = new ConsultaBanco();

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
          coletanea LIKE \'$coletanea\' 
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
