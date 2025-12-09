import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants.dart';
import '../model/login_model.dart';

class RemoteService {

  Future<List<LoginModel>> getRepositories({
    required String username,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$apiBaseUrl$repositoriesEndpoint');
      
      // Create basic auth header
      final credentials = base64Encode(utf8.encode('$username:$password'));
      final headers = {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 403) {
        throw Exception('Invalid credentials');
      }

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isEmpty) {
          return [];
        }
        return jsonList
            .map((json) => LoginModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      throw Exception('Failed to load repositories: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error');
    }
  }
}

