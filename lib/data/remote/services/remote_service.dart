import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../core/constants.dart';
import '../model/login_model.dart';
import 'api_client.dart';

class RemoteService {
  late final ApiClient _apiClient;
  late final Dio _dio;

  RemoteService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    _apiClient = ApiClient(_dio);
  }

  Future<List<LoginModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      // Create basic auth header
      final credentials = base64Encode(utf8.encode('$username:$password'));
      final authorization = 'Basic $credentials';

      final response = await _apiClient.getRepositories(authorization);

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception('Invalid credentials');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      if (e.response?.statusCode != null) {
        throw Exception('Failed to load repositories: ${e.response?.statusCode}');
      }
      throw Exception('Network error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

