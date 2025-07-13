import 'package:flutter_test/flutter_test.dart';
import 'package:pesquisadorhinos/controller/controlaPesquisa.dart';

void main() {
  test('deve retornar um hino ao pesquisar por numero', () async {
    var controle = new ControlaPesquisa();
    await controle.busca('1');
    expect(controle.quantidadeHinos, 1);
  });

  test('deve retornar um hino ao pesquisar por texto', () async {
    var controle = new ControlaPesquisa();
    await controle.busca('hino');
    expect(controle.quantidadeHinos, greaterThan(0));
  });
}
