// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advertising.g.dart';

@JsonSerializable()
class Advertising extends Equatable {
  const Advertising({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String imageUrl;

  factory Advertising.fromJson(Map<String, dynamic> json) =>
      _$AdvertisingFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisingToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
      ];
}
