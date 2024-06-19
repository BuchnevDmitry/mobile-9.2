// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/api.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  const OrderModel({
    required this.startDate,
    required this.endDate,
    required this.receivingMethodId,
    required this.timeReceivingId,
    required this.address,
    required this.tools,
  });

  final String startDate;
  final String endDate;
  final int timeReceivingId;
  final int receivingMethodId;
  final String address;
  final List<RentTool> tools;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  List<Object?> get props {
    return [
      startDate,
      endDate,
      address,
      receivingMethodId,
      timeReceivingId,
      tools,
    ];
  }
}
