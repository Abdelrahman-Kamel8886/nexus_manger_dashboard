import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/repository_navigation_entity.dart';
import '../../../domain/usecases/get_repositories_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final GetRepositoriesUseCase getRepositoriesUseCase;

  LoginCubit(this.getRepositoriesUseCase) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final repos = await getRepositoriesUseCase(
        username: username,
        password: password,
      );

      // Convert Repos to RepositoryNavigationEntity (only name and url)
      final repositories = repos
          .map((repo) => RepositoryNavigationEntity(
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

