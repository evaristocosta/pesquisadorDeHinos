import 'dart:convert';

List<Hino> hinoFromJson(String str) =>
    List<Hino>.from(json.decode(str).map((x) => Hino.fromJson(x)));

class Hino {
  int numero;
  String nome;
  String categoria;
  String coletanea;
  String texto;
  String indicador;

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
}
