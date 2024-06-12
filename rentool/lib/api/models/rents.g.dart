// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rents _$RentsFromJson(Map<String, dynamic> json) => Rents(
      rents: (json['rents'] as List<dynamic>)
          .map((e) => Rent.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$RentsToJson(Rents instance) => <String, dynamic>{
      'rents': instance.rents,
      'size': instance.size,
    };
