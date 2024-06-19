// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertising.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advertising _$AdvertisingFromJson(Map<String, dynamic> json) => Advertising(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$AdvertisingToJson(Advertising instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
