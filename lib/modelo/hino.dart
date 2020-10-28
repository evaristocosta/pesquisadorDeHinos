class Hino {
  String numero;
  String nome;
  String categoria;
  String coletanea;
  String texto;

  Hino({
    this.numero,
    this.nome,
    this.categoria,
    this.coletanea,
    this.texto,
  });

  Hino.fromJson(Map<String, dynamic> json) {
    numero = json['numero'];
    nome = json['nome'];
    categoria = json['categoria'];
    coletanea = json['coletanea'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numero'] = this.numero;
    data['nome'] = this.nome;
    data['categoria'] = this.categoria;
    data['coletanea'] = this.coletanea;
    data['texto'] = this.texto;
    return data;
  }
}
