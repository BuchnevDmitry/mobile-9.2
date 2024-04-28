// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tool _$ToolFromJson(Map<String, dynamic> json) => Tool(
      id: json['id'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
      model: json['model'] as String,
      description: json['description'] as String,
      priceDay: (json['priceDay'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$ToolToJson(Tool instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'brand': instance.brand,
      'model': instance.model,
      'description': instance.description,
      'priceDay': instance.priceDay,
      'count': instance.count,
      'imageUrl': instance.imageUrl,
    };
