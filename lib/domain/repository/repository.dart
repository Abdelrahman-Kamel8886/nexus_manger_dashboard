import '../entity/repos_entity.dart';

abstract class Repository {
  Future<List<Repos>> getRepositories({
    required String username,
    required String password,
  });
}

