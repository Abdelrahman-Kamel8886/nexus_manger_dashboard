import '../entity/login_entity.dart';

abstract class LoginRepository {

  String concatUsername(String username);

  Future<List<LoginEntity>> login({
    required String username,
    required String password,
  });
}

