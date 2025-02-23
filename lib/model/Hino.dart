import 'dart:convert';

List<Hino> hinoFromJson(String str) =>
    List<Hino>.from(json.decode(str).map((x) => Hino.fromJson(x)));

class Hino {
  int idhinos = 0;
  int? numero;
  String nome = "";
  String categoria = "";
  String coletanea = "";
  String texto = "";
  String indicador = "";

  Hino(
      {required this.idhinos,
      this.numero,
      required this.nome,
      required this.categoria,
      required this.coletanea,
      required this.texto,
      required this.indicador});

  Hino.fromJson(Map<String, dynamic> json) {
    idhinos = json['idhinos'];
    numero = json['numero'];
    nome = json['nome'];
    categoria = json['categoria'];
    coletanea = json['coletanea'];
    texto = json['texto'];
  }
}
