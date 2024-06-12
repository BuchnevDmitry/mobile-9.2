// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_receiving.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeReceiving _$TimeReceivingFromJson(Map<String, dynamic> json) =>
    TimeReceiving(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TimeReceivingToJson(TimeReceiving instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
