import 'package:dio/dio.dart';
import 'package:rentool/api/models/models.dart';
import 'package:retrofit/http.dart';

part 'categories_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class CategoriesApiClient {
  factory CategoriesApiClient(Dio dio, {String baseUrl}) = _CategoriesApiClient;

  factory CategoriesApiClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return CategoriesApiClient(dio, baseUrl: apiUrl);
    }
    return CategoriesApiClient(dio);
  }

  @GET('/api/v1/categories/')
  Future<Categories> getCategories({
    @Query('page') int page = 0,
    @Query('size') int size = 20,
  });
}
