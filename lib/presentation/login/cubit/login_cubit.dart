import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nexus_manger_dashboard/domain/entity/login_entity.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final repos = await loginUseCase(
        username: username,
        password: password,
      );

      // Convert Repos to RepositoryNavigationEntity (only name and url)
      final repositories = repos
          .map((repo) => LoginEntity(
                name: repo.name,
                url: repo.url,
              ))
          .toList();

      emit(LoginSuccess(repositories: repositories));
    } on Exception catch (e) {
      emit(LoginError(message: e.toString().replaceFirst('Exception: ', '')));
    } catch (e) {
      emit(LoginError(message: 'An unexpected error occurred'));
    }
  }
}

