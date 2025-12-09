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
    if(username.toLowerCase().contains("secon")){
      const  envUsername = String.fromEnvironment('SECON', defaultValue: '');
      return envUsername.isNotEmpty ? '$envUsername-$username' : username;
    }
    else if(username.toLowerCase().contains("partial")){
      const  envUsername = String.fromEnvironment('PARTIAL', defaultValue: '');
      return envUsername.isNotEmpty ? '$envUsername-$username' : username;
    }
    else if(username.toLowerCase().contains("production")){
      const envUsername = String.fromEnvironment('PRODUCTION', defaultValue: '');
      return envUsername.isNotEmpty ? '$envUsername-$username' : username;
    }
    else{
      const envUsername = String.fromEnvironment('USERNAME', defaultValue: '');
      return envUsername.isNotEmpty ? '$envUsername-$username' : username;
    }


  }
}

