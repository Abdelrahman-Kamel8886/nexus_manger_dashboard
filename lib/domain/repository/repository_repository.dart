import '../entity/repository_entity.dart';

abstract class RepositoryRepository {
  Future<List<RepositoryEntity>> getRepositories({
    required String username,
    required String password,
  });
}

