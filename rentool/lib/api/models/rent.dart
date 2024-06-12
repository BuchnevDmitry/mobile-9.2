// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/api.dart';

part 'rent.g.dart';

@JsonSerializable()
class Rent extends Equatable {
  const Rent({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.status,
    required this.receivingMethod,
    required this.timeReceiving,
    required this.tools,
  });

  final String id;
  final String startDate;
  final String endDate;
  final int price;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final Status status;
  final ReceivingMethod receivingMethod;
  final TimeReceiving timeReceiving;
  final String address;
  final List<RentTool> tools;

  factory Rent.fromJson(Map<String, dynamic> json) => _$RentFromJson(json);

  Map<String, dynamic> toJson() => _$RentToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      startDate,
      endDate,
      price,
      userId,
      createdAt,
      updatedAt,
      address,
      status,
      receivingMethod,
      timeReceiving,
      tools,
    ];
  }
}
