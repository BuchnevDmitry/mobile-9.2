// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rentool/api/models/models.dart';

part 'rents.g.dart';

@JsonSerializable()
class Rents extends Equatable {
  const Rents({
    required this.rents,
    required this.size,
  });

  final List<Rent> rents;
  final int size;

  factory Rents.fromJson(Map<String, dynamic> json) => _$RentsFromJson(json);

  Map<String, dynamic> toJson() => _$RentsToJson(this);

  @override
  List<Object> get props => [rents, size];
}
