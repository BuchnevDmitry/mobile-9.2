// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extend.g.dart';

@JsonSerializable()
class Extend extends Equatable {
  const Extend({
    required this.endDate,
  });

  final String endDate;

  factory Extend.fromJson(Map<String, dynamic> json) => _$ExtendFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendToJson(this);

  @override
  List<Object?> get props {
    return [endDate];
  }
}
