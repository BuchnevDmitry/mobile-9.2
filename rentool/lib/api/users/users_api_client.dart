import 'package:dio/dio.dart';
import 'package:rentool/api/api.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'users_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class UsersApiClient {
  factory UsersApiClient(Dio dio, {String baseUrl}) = _UsersApiClient;

  factory UsersApiClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return UsersApiClient(dio, baseUrl: apiUrl);
    }
    return UsersApiClient(dio);
  }

  @POST('/api/v1/users/')
  Future<User> registerUser(@Body() User user);

  @PATCH('/api/v1/users/change-password')
  Future<User> changeUserPassword(
    @Header('Authorization') String token,
    @Body() Password password, {
    @Header('Content-Type') String type = 'application/json',
  });

  @GET('/api/v1/users/profile')
  Future<User> getUserProfile(@Header('Authorization') String token);
}
