import 'package:json_annotation/json_annotation.dart';

part 'persona.class.g.dart';

@JsonSerializable()
class Persona {
  String documento = "";
  String nombre = "";
  String edad = "";

  Persona(this.documento, this.nombre, this.edad);

  factory Persona.fomJson(Map<String, dynamic> json) => _$PersonaFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaToJson(this);
}
