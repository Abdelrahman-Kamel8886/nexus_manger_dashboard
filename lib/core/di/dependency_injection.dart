import '../../data/remote/services/remote_service.dart';
import '../../data/repository/repository_impl.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecases/get_repositories_usecase.dart';
import '../../presentation/login/cubit/login_cubit.dart';

class DependencyInjection {
  static LoginCubit getLoginCubit() {
    final service = RemoteService();
    final repository = RepositoryImpl(service) as Repository;
    final useCase = GetRepositoriesUseCase(repository);
    return LoginCubit(useCase);
  }
}

