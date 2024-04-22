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

  @GET('/tools')
  Future<Tools> getTools();
}
