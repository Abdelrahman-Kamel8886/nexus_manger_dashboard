import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../../../core/constants.dart';
import '../model/login_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(repositoriesEndpoint)
  @Headers({'Content-Type': 'application/json'})
  Future<List<LoginModel>> getRepositories(
    @Header('Authorization') String authorization,
  );
}
