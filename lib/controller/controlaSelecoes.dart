import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import 'package:pesquisadorhinos/controller/conectaBancoDeDados.dart';
import 'package:pesquisadorhinos/model/Hino.dart';
import 'package:pesquisadorhinos/model/SelecoesDisponiveis.dart';

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

class ControlaSelecoes {
  List<Hino> hinos;
  List<SelecoesDisponiveis> selecoes;

  int get quantidadeSelecoes {
    return selecoes?.length ?? 0;
  }

  int get quantidadeHinos {
    return hinos?.length ?? 0;
  }

  listaSelecoes() {
    selecoes = [
      SelecoesDisponiveis(0, 'tema', 'Seleção por tema',
          'Louvores organizados pelos temas da coletânea (clamor, dedicação, etc.)'),
      SelecoesDisponiveis(0, 'alfabeto', 'ordem alfabética',
          'Categorizados por sequência alfabética, independente da coletânea'),
      SelecoesDisponiveis(0, 'coletanea', 'coletâneas',
          'Todos os hinos de uma das coletâneas disponíveis: comum, de crianças ou avulsa'),
      SelecoesDisponiveis(0, 'culto', 'cultos especiais',
          'Hinos para cantar em cultos de ceia, casamento ou sepultamento'),
      SelecoesDisponiveis(0, 'sugestao', 'sugestões',
          'Listas de sugestões para adolescentes, jovens e senhoras')
    ];
    return selecoes;
  }

  lidaComSelecao(String id) {
    switch (id) {
      case 'tema':
        break;
      case 'alfabeto':
        selecoes = alfabeto
            .map((letra) => SelecoesDisponiveis(1, '', letra, ''))
            .toList();
        return selecoes;
        break;
      default:
    }
  }

  buscaAlfabeto(String letra) async {
    var caminho = await conectaBancoDeDados();
    var pesquisa;

    // open the database
    Database bd = await openDatabase(caminho, readOnly: true);

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
          texto LIKE \'$letra%\' 
      """;

    try {
      hinos = hinoFromJson(jsonEncode(await bd.rawQuery(pesquisa)));

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

    await bd.close();
  }
}
