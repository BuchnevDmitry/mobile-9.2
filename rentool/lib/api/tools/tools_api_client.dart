import 'package:dio/dio.dart';
import 'package:rentool/api/models/models.dart';
import 'package:retrofit/http.dart';

part 'tools_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ToolsApiClient {
  factory ToolsApiClient(Dio dio, {String baseUrl}) = _ToolsApiClient;

  factory ToolsApiClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return ToolsApiClient(dio, baseUrl: apiUrl);
    }
    return ToolsApiClient(dio);
  }

  @GET('/api/v1/tools/')
  Future<Tools> getTools({
    @Query('page') int page = 0,
    @Query('size') int size = 5,
    @Query('sortParam') String sortParam = 'PRICE_ASC',
  });

  @GET('/api/v1/tools/{id}')
  Future<Tool> getToolById(
    @Path('id') String id,
  );

  @GET('/api/v1/tools/by-ids')
  Future<Tools> getToolsByIds(
    @Query('listIds') List<String> array,
  );

  @GET('/api/v1/tools/search')
  Future<Tools> getToolsByCategory(
    @Query('category') String category, {
    @Query('page') int page = 0,
    @Query('size') int size = 50,
    @Query('sortParam') String sortParam = 'PRICE_ASC',
  });
}
