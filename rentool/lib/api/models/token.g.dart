// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      access_token: json['access_token'] as String,
      expires_in: (json['expires_in'] as num).toInt(),
      refresh_expires_in: (json['refresh_expires_in'] as num).toInt(),
      refresh_token: json['refresh_token'] as String,
      token_type: json['token_type'] as String,
      session_state: json['session_state'] as String,
      scope: json['scope'] as String,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'expires_in': instance.expires_in,
      'refresh_expires_in': instance.refresh_expires_in,
      'refresh_token': instance.refresh_token,
      'token_type': instance.token_type,
      'session_state': instance.session_state,
      'scope': instance.scope,
    };
