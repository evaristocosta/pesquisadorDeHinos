import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pesquisadorhinos/database/consultaBanco.dart';
import 'package:pesquisadorhinos/model/SelecoesDisponiveis.dart';

class ControlaSelecoes {
  List<SelecoesDisponiveis> selecoes;
  ConsultaBanco consultaBanco;

  int get quantidadeSelecoes {
    return selecoes?.length ?? 0;
  }

  listaSelecoes() {
    selecoes = [
      SelecoesDisponiveis(0, 'tema', 'Seleção por tema',
          'Louvores organizados pelos temas da coletânea (clamor, dedicação, etc.)'),
      SelecoesDisponiveis(0, 'alfabeto', 'ordem alfabética',
          'Categorizados por sequência alfabética, independente da coletânea'),
      SelecoesDisponiveis(0, 'coletanea', 'coletâneas',
          'Todos os hinos de uma das coletâneas disponíveis: comum, de crianças ou avulsa'),
      SelecoesDisponiveis(0, 'especiais', 'cultos especiais',
          'Hinos para cantar em cultos de ceia, casamento ou sepultamento'),
      SelecoesDisponiveis(0, 'sugestoes', 'sugestões',
          'Listas de sugestões para adolescentes, jovens e senhoras')
    ];
    return selecoes;
  }

  lidaComSelecao(String id) async {
    consultaBanco = new ConsultaBanco();

    switch (id) {
      case 'tema':
        var pesquisa = "SELECT DISTINCT categoria FROM hinos";
        List resposta = json.decode(await consultaBanco.pesquisa(pesquisa));

        selecoes = resposta.map((categoria) {
          if (categoria['categoria'] != null)
            return SelecoesDisponiveis(1, 'tema', categoria['categoria'], '');
        }).toList();
        selecoes.removeWhere((elemento) => elemento == null);

        return selecoes;
        break;

      case 'alfabeto':
        selecoes = alfabeto
            .map((letra) => SelecoesDisponiveis(1, 'alfabeto', letra, ''))
            .toList();
        return selecoes;
        break;

      case 'coletanea':
        var pesquisa = "SELECT DISTINCT coletanea FROM hinos";
        List resposta = json.decode(await consultaBanco.pesquisa(pesquisa));

        selecoes = resposta.map((coletanea) {
          if (coletanea['coletanea'] != null)
            return SelecoesDisponiveis(
                1, 'coletanea', coletanea['coletanea'], '');
        }).toList();
        selecoes.removeWhere((elemento) => elemento == null);

        return selecoes;
        break;

      case 'especiais':
        Map especiais = json.decode(
            await rootBundle.loadString('assets/database/especiais.json'));
        List listaEspeciais = especiais.keys.toList();
        selecoes = listaEspeciais
            .map(
                (especial) => SelecoesDisponiveis(1, 'especiais', especial, ''))
            .toList();

        return selecoes;
        break;

      case 'sugestoes':
        Map sugestoes = json.decode(
            await rootBundle.loadString('assets/database/sugestoes.json'));
        List listaSugestoes = sugestoes.keys.toList();
        selecoes = listaSugestoes
            .map(
                (sugestao) => SelecoesDisponiveis(1, 'sugestoes', sugestao, ''))
            .toList();

        return selecoes;
        break;

      default:
    }
  }
}

List alfabeto = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
