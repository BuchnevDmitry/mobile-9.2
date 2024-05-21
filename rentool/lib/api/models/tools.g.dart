// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tools.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tools _$ToolsFromJson(Map<String, dynamic> json) => Tools(
      tools: (json['tools'] as List<dynamic>)
          .map((e) => Tool.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$ToolsToJson(Tools instance) => <String, dynamic>{
      'tools': instance.tools,
      'size': instance.size,
    };
