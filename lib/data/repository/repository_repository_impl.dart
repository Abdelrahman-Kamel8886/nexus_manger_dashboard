import '../../domain/repository/repository_repository.dart';
import '../../domain/entity/repository_entity.dart';
import '../remote/services/repository_service.dart';
import '../mappers/repository_mapper.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryService _service;

  RepositoryRepositoryImpl(this._service);

  @override
  Future<List<RepositoryEntity>> getRepositories({
    required String username,
    required String password,
  }) async {
    final dtos = await _service.getRepositories(
      username: username,
      password: password,
    );
    return RepositoryMapper.toEntityList(dtos);
  }
}

