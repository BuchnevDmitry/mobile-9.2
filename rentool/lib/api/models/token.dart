// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token extends Equatable {
  const Token({
    required this.access_token,
    required this.expires_in,
    required this.refresh_expires_in,
    required this.refresh_token,
    required this.token_type,
    required this.session_state,
    required this.scope,
  });

  final String access_token;
  final int expires_in;
  final int refresh_expires_in;
  final String refresh_token;
  final String token_type;
  final String session_state;
  final String scope;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  List<Object> get props => [
        access_token,
        expires_in,
        refresh_expires_in,
        refresh_token,
        token_type,
        session_state,
        scope,
      ];
}
