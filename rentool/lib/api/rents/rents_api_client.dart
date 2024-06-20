import 'package:dio/dio.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/api/models/models.dart';
import 'package:retrofit/http.dart';

part 'rents_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class RentsApiClient {
  factory RentsApiClient(Dio dio, {String baseUrl}) = _RentsApiClient;

  factory RentsApiClient.create({String? apiUrl}) {
    final dio = Dio();
    dio.options.followRedirects = true;
    dio.interceptors.add(LogInterceptor(responseBody: true));
    if (apiUrl != null) {
      return RentsApiClient(dio, baseUrl: apiUrl);
    }
    return RentsApiClient(dio);
  }

  @GET('/api/v1/rents/user')
  Future<Rents> getRents(
    @Header('Authorization') String token, {
    @Query('page') int page = 0,
    @Query('size') int size = 10,
  });

  @POST('/api/v1/rents/')
  Future<void> addRent(
    @Header('Authorization') String token,
    @Body() OrderModel order, {
    @Header('Content-Type') String type = 'application/json',
  });

  @PATCH('/api/v1/rents/{id}/return')
  Future<void> returnRent(
    @Path('id') String id,
    @Header('Authorization') String token,
  );

  @PATCH('/api/v1/rents/{id}/cancel')
  Future<void> cancelRent(
    @Path('id') String id,
    @Header('Authorization') String token,
  );

  @PATCH('/api/v1/rents/{id}/extend')
  Future<void> extendRent(
    @Path('id') String id,
    @Header('Authorization') String token,
    @Body() Extend endDate, {
    @Header('Content-Type') String type = 'application/json',
  });

  @GET('/api/v1/advertising/')
  Future<List<Advertising>> getAdvertisings({
    @Query('page') int page = 0,
    @Query('size') int size = 10,
  });
}
