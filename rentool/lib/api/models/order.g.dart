// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      receivingMethodId: (json['receivingMethodId'] as num).toInt(),
      timeReceivingId: (json['timeReceivingId'] as num).toInt(),
      address: json['address'] as String,
      tools: (json['tools'] as List<dynamic>)
          .map((e) => RentTool.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'timeReceivingId': instance.timeReceivingId,
      'receivingMethodId': instance.receivingMethodId,
      'address': instance.address,
      'tools': instance.tools,
    };
