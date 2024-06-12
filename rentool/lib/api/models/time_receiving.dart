// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_receiving.g.dart';

@JsonSerializable()
class TimeReceiving extends Equatable {
  const TimeReceiving({
    required this.id,
    required this.name,
    required this.description,
  });

  final int id;
  final String name;
  final String description;

  factory TimeReceiving.fromJson(Map<String, dynamic> json) =>
      _$TimeReceivingFromJson(json);

  Map<String, dynamic> toJson() => _$TimeReceivingToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        description,
      ];
}
