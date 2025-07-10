class SelecoesDisponiveis {
  int? tipo;
  String? id;
  String? nome;
  String? descricao;

  SelecoesDisponiveis(int? tipo, String? id, String? nome, String? descricao) {
    this.tipo = tipo;
    this.id = id;
    this.nome = nome?.toUpperCase();
    this.descricao = descricao;
  }
}
