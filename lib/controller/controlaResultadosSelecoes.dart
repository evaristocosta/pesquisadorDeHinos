import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pesquisadorhinos/database/consultaBanco.dart';
import 'package:pesquisadorhinos/model/Hino.dart';

class ControlaResultadosSelecoes {
  List<Hino> hinos;
  ConsultaBanco consultaBanco;

  int get quantidadeHinos {
    return hinos?.length ?? 0;
  }

  buscaTemaLetraOuColetanea(String id, String busca) async {
    consultaBanco = new ConsultaBanco();

    String coluna, pesquisa, escolhidos = "(";

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

      case 'especiais':
        Map especiais = json.decode(
            await rootBundle.loadString('assets/database/especiais.json'));
        List listaEspeciais = especiais[busca.toLowerCase()].toList();
        listaEspeciais.forEach((especial) {
          escolhidos += "$especial,";
        });
        escolhidos = escolhidos.substring(0, escolhidos.length - 1);
        escolhidos += ')';
        break;

      case 'sugestoes':
        Map sugestoes = json.decode(
            await rootBundle.loadString('assets/database/sugestoes.json'));
        List listaSugestoes = sugestoes[busca.toLowerCase()].toList();
        listaSugestoes.forEach((sugestao) {
          escolhidos += "$sugestao,";
        });
        escolhidos = escolhidos.substring(0, escolhidos.length - 1);
        escolhidos += ')';
        break;
    }

    if (['tema', 'alfabeto', 'coletanea'].contains(id)) {
      pesquisa = """
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
    } else {
      pesquisa = """
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
          numero IN $escolhidos AND coletanea='COLETÂNEA'
        ORDER BY numero
      """;
    }

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
