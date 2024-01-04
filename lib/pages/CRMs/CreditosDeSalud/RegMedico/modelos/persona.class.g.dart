// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona.class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      json['documento'] as String,
      json['nombre'] as String,
      json['edad'] as String,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      'documento': instance.documento,
      'nombre': instance.nombre,
      'edad': instance.edad,
    };
