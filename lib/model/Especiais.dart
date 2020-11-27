// To parse this JSON data, do
//
//     final especiais = especiaisFromJson(jsonString);

import 'dart:convert';

Especiais especiaisFromJson(String str) => Especiais.fromJson(json.decode(str));

String especiaisToJson(Especiais data) => json.encode(data.toJson());

class Especiais {
  Especiais({
    this.especiais,
  });

  EspeciaisClass especiais;

  factory Especiais.fromJson(Map<String, dynamic> json) => Especiais(
        especiais: EspeciaisClass.fromJson(json["especiais"]),
      );

  Map<String, dynamic> toJson() => {
        "especiais": especiais.toJson(),
      };
}

class EspeciaisClass {
  EspeciaisClass({
    this.ceia,
    this.casamento,
    this.sepultamento,
  });

  List<String> ceia;
  List<String> casamento;
  List<String> sepultamento;

  factory EspeciaisClass.fromJson(Map<String, dynamic> json) => EspeciaisClass(
        ceia: List<String>.from(json["ceia"].map((x) => x)),
        casamento: List<String>.from(json["casamento"].map((x) => x)),
        sepultamento: List<String>.from(json["sepultamento"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ceia": List<dynamic>.from(ceia.map((x) => x)),
        "casamento": List<dynamic>.from(casamento.map((x) => x)),
        "sepultamento": List<dynamic>.from(sepultamento.map((x) => x)),
      };
}
