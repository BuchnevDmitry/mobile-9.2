// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingMethod _$ReceivingMethodFromJson(Map<String, dynamic> json) =>
    ReceivingMethod(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ReceivingMethodToJson(ReceivingMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
