// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/models/models.dart';

part 'tool.g.dart';

@JsonSerializable()
class Tool extends Equatable {
  const Tool({
    required this.id,
    required this.category,
    required this.brand,
    required this.model,
    required this.description,
    required this.priceHour,
    required this.count,
    required this.imageUrl,
  });

  final String id;
  final Category category;
  final Brand brand;
  final String model;
  final String description;
  final int priceHour;
  final int count;
  final String imageUrl;

  factory Tool.fromJson(Map<String, dynamic> json) => _$ToolFromJson(json);

  Map<String, dynamic> toJson() => _$ToolToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      category,
      brand,
      model,
      description,
      priceHour,
      count,
      imageUrl,
    ];
  }
}
