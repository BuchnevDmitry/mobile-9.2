// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rent_tool.g.dart';

@JsonSerializable()
class RentTool extends Equatable {
  const RentTool({
    required this.toolId,
    required this.countTool,
  });

  final String toolId;
  final int countTool;

  factory RentTool.fromJson(Map<String, dynamic> json) =>
      _$RentToolFromJson(json);

  Map<String, dynamic> toJson() => _$RentToolToJson(this);

  @override
  List<Object> get props {
    return [
      toolId,
      countTool,
    ];
  }
}
