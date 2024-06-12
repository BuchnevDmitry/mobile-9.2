// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receiving_method.g.dart';

@JsonSerializable()
class ReceivingMethod extends Equatable {
  const ReceivingMethod({
    required this.id,
    required this.name,
    required this.description,
  });

  final int id;
  final String name;
  final String description;

  factory ReceivingMethod.fromJson(Map<String, dynamic> json) =>
      _$ReceivingMethodFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivingMethodToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        description,
      ];
}
