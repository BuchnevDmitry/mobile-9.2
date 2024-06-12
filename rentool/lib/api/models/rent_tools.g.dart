// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_tools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RentTools _$RentToolsFromJson(Map<String, dynamic> json) => RentTools(
      tools: (json['tools'] as List<dynamic>)
          .map((e) => RentTool.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RentToolsToJson(RentTools instance) => <String, dynamic>{
      'tools': instance.tools,
    };
