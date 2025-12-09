import '../../domain/repository/login_repository.dart';
import '../../domain/entity/login_entity.dart';
import '../remote/services/remote_service.dart';
import '../mappers/login_mapper.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RemoteService _service;

  LoginRepositoryImpl(this._service);

  @override
  Future<List<LoginEntity>> login({
    required String username,
    required String password,
  }) async {
    final dtos = await _service.login(
      username: concatUsername(username),
      password: password,
    );
    return LoginMapper.toEntityList(dtos);
  }

  @override
  String concatUsername(String username) {
    const envUsername = String.fromEnvironment('USERNAME', defaultValue: '');
    return envUsername.isNotEmpty ? '$envUsername-$username' : username;
  }
}

