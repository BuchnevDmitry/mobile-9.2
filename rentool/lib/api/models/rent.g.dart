// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rent _$RentFromJson(Map<String, dynamic> json) => Rent(
      id: json['id'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      price: (json['price'] as num).toInt(),
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      address: json['address'] as String,
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      receivingMethod: ReceivingMethod.fromJson(
          json['receivingMethod'] as Map<String, dynamic>),
      timeReceiving:
          TimeReceiving.fromJson(json['timeReceiving'] as Map<String, dynamic>),
      tools: (json['tools'] as List<dynamic>)
          .map((e) => RentTool.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RentToJson(Rent instance) => <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'price': instance.price,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'status': instance.status,
      'receivingMethod': instance.receivingMethod,
      'timeReceiving': instance.timeReceiving,
      'address': instance.address,
      'tools': instance.tools,
    };
