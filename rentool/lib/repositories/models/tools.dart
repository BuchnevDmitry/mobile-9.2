// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/repositories/models/models.dart';

part 'tools.g.dart';

@JsonSerializable()
class Tools extends Equatable {
  const Tools({
    required this.tools,
  });

  final List<Tool> tools;

  factory Tools.fromJson(Map<String, dynamic> json) => _$ToolsFromJson(json);

  Map<String, dynamic> toJson() => _$ToolsToJson(this);

  @override
  List<Object> get props => [tools];
}
