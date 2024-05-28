// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User extends Equatable {
  const User({
    this.id,
    this.login,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  });

  final String? id;
  final String? login;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        login,
        password,
        firstName,
        lastName,
        phone,
        email,
      ];
}
