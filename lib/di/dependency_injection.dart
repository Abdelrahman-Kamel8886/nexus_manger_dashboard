import '../../data/remote/services/remote_service.dart';
import '../../data/repository/login_repository_impl.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/login/cubit/login_cubit.dart';

class DependencyInjection {
  static LoginCubit getLoginCubit() {
    final service = RemoteService();
    final repository = LoginRepositoryImpl(service) as LoginRepository;
    final useCase = LoginUseCase(repository);
    return LoginCubit(useCase);
  }
}

