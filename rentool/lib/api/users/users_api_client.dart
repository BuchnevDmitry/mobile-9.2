import 'package:dio/dio.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/api/models/models.dart';
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

  @GET('/api/v1/users/{id}')
  Future<User> getUserById(
    @Path('id') String id,
    @Header('Authorization') String token,
  );
}
