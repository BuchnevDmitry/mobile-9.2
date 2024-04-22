// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/models/models.dart';

part 'categories.g.dart';

@JsonSerializable()
class Categories extends Equatable {
  const Categories({
    required this.categories,
  });

  final List<Category> categories;

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);

  @override
  List<Object> get props => [categories];
}
