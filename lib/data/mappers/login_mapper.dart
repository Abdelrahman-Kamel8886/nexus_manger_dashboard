import '../../domain/entity/login_entity.dart';
import '../remote/model/login_model.dart';

class LoginMapper {
  static LoginEntity toEntity(LoginModel dto) {
    return LoginEntity(
      name: dto.name,
      url: dto.url,
    );
  }

  static List<LoginEntity> toEntityList(List<LoginModel> dtos) {
    return dtos.map((dto) => toEntity(dto)).toList();
  }
}

