import '../remote/dto/repos_dto.dart';
import '../../domain/entity/repos_entity.dart';

class ReposMapper {
  static Repos toEntity(ReposDto dto) {
    return Repos(
      name: dto.name,
      format: dto.format,
      type: dto.type,
      url: dto.url,
      size: dto.size,
      attributes: dto.attributes,
    );
  }

  static List<Repos> toEntityList(List<ReposDto> dtos) {
    return dtos.map((dto) => toEntity(dto)).toList();
  }
}

