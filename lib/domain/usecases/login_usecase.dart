import '../entity/login_entity.dart';
import '../repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<List<LoginEntity>> call({
    required String username,
    required String password,
  }) async {
    return await repository.login(
      username: username,
      password: password,
    );
  }
}

