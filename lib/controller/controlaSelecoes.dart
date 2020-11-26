import 'package:pesquisadorhinos/model/SelecoesDisponiveis.dart';

class ControlaSelecoes {
  List<SelecoesDisponiveis> selecoes;

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
      SelecoesDisponiveis(1, 'culto', 'cultos especiais',
          'Hinos para cantar em cultos de ceia, casamento ou sepultamento'),
      SelecoesDisponiveis(1, 'sugestao', 'sugestões',
          'Listas de sugestões para adolescentes, jovens e senhoras')
    ];
    return selecoes;
  }

  lidaComSelecao(String id) async {
    switch (id) {
      case 'tema':
        break;

      case 'alfabeto':
        selecoes = alfabeto
            .map((letra) => SelecoesDisponiveis(1, '', letra, ''))
            .toList();
        return selecoes;
        break;

      case 'coletanea':
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
