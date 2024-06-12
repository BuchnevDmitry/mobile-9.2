// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RentTool _$RentToolFromJson(Map<String, dynamic> json) => RentTool(
      toolId: json['toolId'] as String,
      countTool: (json['countTool'] as num).toInt(),
    );

Map<String, dynamic> _$RentToolToJson(RentTool instance) => <String, dynamic>{
      'toolId': instance.toolId,
      'countTool': instance.countTool,
    };
