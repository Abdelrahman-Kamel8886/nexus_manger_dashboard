import '../entity/repos_entity.dart';
import '../repository/repository.dart';

class GetRepositoriesUseCase {
  final Repository repository;

  GetRepositoriesUseCase(this.repository);

  Future<List<Repos>> call({
    required String username,
    required String password,
  }) async {
    return await repository.getRepositories(
      username: username,
      password: password,
    );
  }
}

