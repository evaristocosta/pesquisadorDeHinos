import 'package:pesquisadorhinos/model/SelecoesDisponiveis.dart';

class ControlaSelecoes {
  List<SelecoesDisponiveis> selecoes;

  int get quantidadeSelecoes {
    return selecoes.length;
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
        selecoes = [
          SelecoesDisponiveis(1, '', 'A', ''),
          SelecoesDisponiveis(1, '', 'B', ''),
          SelecoesDisponiveis(1, '', 'C', ''),
          SelecoesDisponiveis(1, '', 'D', ''),
          SelecoesDisponiveis(1, '', 'E', ''),
        ];
        return selecoes;
        break;
      default:
    }
  }
}
