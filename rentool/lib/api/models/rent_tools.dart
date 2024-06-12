// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/models/models.dart';

part 'rent_tools.g.dart';

@JsonSerializable()
class RentTools extends Equatable {
  const RentTools({
    required this.tools,
  });

  final List<RentTool> tools;

  factory RentTools.fromJson(Map<String, dynamic> json) =>
      _$RentToolsFromJson(json);

  Map<String, dynamic> toJson() => _$RentToolsToJson(this);

  @override
  List<Object> get props => [tools];
}
