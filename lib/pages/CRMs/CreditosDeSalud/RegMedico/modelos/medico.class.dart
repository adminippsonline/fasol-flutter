import 'package:json_annotation/json_annotation.dart';

//part 'persona.class.g.dart';

@JsonSerializable()
class Medico {
  String id_medico = "";
  String PrimerNombre = "";
  String SegundoNombre = "";

  Medico(this.id_medico, this.PrimerNombre, this.SegundoNombre);

  //factory Medico.fomJson(Map<String, dynamic> json) => _$MedicoFromJson(json);

  //Map<String, dynamic> toJson() => _$MedicoToJson(this);
}
