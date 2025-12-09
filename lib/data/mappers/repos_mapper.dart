import '../../domain/entity/repos_entity.dart';
import '../remote/model/repos_model.dart';

class ReposMapper {
  static RepoEntity toEntity(ReposDto dto) {
    return RepoEntity(
      name: dto.name,
      url: dto.url,
    );
  }

  static List<RepoEntity> toEntityList(List<ReposDto> dtos) {
    return dtos.map((dto) => toEntity(dto)).toList();
  }
}

