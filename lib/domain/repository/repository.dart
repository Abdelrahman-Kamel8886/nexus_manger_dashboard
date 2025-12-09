import '../entity/repos_entity.dart';

abstract class Repository {
  Future<List<RepoEntity>> getRepositories({
    required String username,
    required String password,
  });
}

