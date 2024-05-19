// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/models/models.dart';
import 'package:rentool/repositories/repositories.dart';

part 'tool.g.dart';

@JsonSerializable()
class Tool extends Equatable {
  const Tool({
    required this.id,
    required this.category,
    required this.brand,
    required this.model,
    required this.description,
    required this.priceDay,
    required this.count,
    required this.imageUrl,
  });

  final String id;
  final Category category;
  final Brand brand;
  final String model;
  final String description;
  final int priceDay;
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
      priceDay,
      count,
      imageUrl,
    ];
  }

  ToolOrder toToolOrder(int userCount) => ToolOrder(
        id,
        model,
        description,
        priceDay,
        count,
        userCount,
        imageUrl,
        category: CategoryOrder(
          category.id,
          category.name,
        ),
        brand: BrandOrder(
          brand.id,
          brand.name,
        ),
      );

  ToolFavorite toToolFavorite() => ToolFavorite(
        id,
        model,
        description,
        priceDay,
        count,
        imageUrl,
        category: CategoryFavorite(
          category.id,
          category.name,
        ),
        brand: BrandFavorite(
          brand.id,
          brand.name,
        ),
      );
}
