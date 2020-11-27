import 'package:pesquisadorhinos/database/consultaBanco.dart';
import 'package:pesquisadorhinos/model/Hino.dart';

class ProcessaHinos {
  List<Hino> hinos;
  ConsultaBanco consultaBanco;

  preencher(String pesquisa) async {
    consultaBanco = new ConsultaBanco();

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

      return hinos;
    } catch (e) {
      print(e);
    }
  }
}
