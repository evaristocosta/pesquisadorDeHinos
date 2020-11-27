// To parse this JSON data, do
//
//     final sugestoes = sugestoesFromJson(jsonString);

import 'dart:convert';

Sugestoes sugestoesFromJson(String str) => Sugestoes.fromJson(json.decode(str));

String sugestoesToJson(Sugestoes data) => json.encode(data.toJson());

class Sugestoes {
  Sugestoes({
    this.sugestoes,
  });

  SugestoesClass sugestoes;

  factory Sugestoes.fromJson(Map<String, dynamic> json) => Sugestoes(
        sugestoes: SugestoesClass.fromJson(json["sugestoes"]),
      );

  Map<String, dynamic> toJson() => {
        "sugestoes": sugestoes.toJson(),
      };
}

class SugestoesClass {
  SugestoesClass({
    this.adolescentes,
    this.jovens,
    this.senhoras,
  });

  List<String> adolescentes;
  List<String> jovens;
  List<String> senhoras;

  factory SugestoesClass.fromJson(Map<String, dynamic> json) => SugestoesClass(
        adolescentes: List<String>.from(json["adolescentes"].map((x) => x)),
        jovens: List<String>.from(json["jovens"].map((x) => x)),
        senhoras: List<String>.from(json["senhoras"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "adolescentes": List<dynamic>.from(adolescentes.map((x) => x)),
        "jovens": List<dynamic>.from(jovens.map((x) => x)),
        "senhoras": List<dynamic>.from(senhoras.map((x) => x)),
      };
}
