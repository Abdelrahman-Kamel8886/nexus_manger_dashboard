import '../../domain/repository/repository.dart';
import '../../domain/entity/repos_entity.dart';
import '../remote/services/remote_service.dart';
import '../mappers/repos_mapper.dart';

class RepositoryImpl implements Repository {
  final RemoteService _service;

  RepositoryImpl(this._service);

  @override
  Future<List<RepoEntity>> getRepositories({
    required String username,
    required String password,
  }) async {
    final dtos = await _service.getRepositories(
      username: username,
      password: password,
    );
    return ReposMapper.toEntityList(dtos);
  }
}

