import 'package:dio/dio.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/api/models/models.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: '')
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  factory AuthClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return AuthClient(dio, baseUrl: apiUrl);
    }
    return AuthClient(dio);
  }

  @FormUrlEncoded()
  @POST('/realms/rentool/protocol/openid-connect/token')
  Future<Token> auth(
    @Field('client_id') String clientId,
    @Field('client_secret') String clientSecret,
    @Field('grant_type') String grantType,
    @Field('username') String username,
    @Field('password') String password,
  );

  @FormUrlEncoded()
  @POST('/realms/rentool/protocol/openid-connect/token')
  Future<Token> refresh(
    @Field('client_id') String clientId,
    @Field('grant_type') String grantType,
    @Field('refresh_token') String refreshToken,
    @Field('client_secret') String clientSecret,
  );
}
