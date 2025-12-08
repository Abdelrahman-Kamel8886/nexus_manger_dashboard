import '../remote/dto/repository_dto.dart';
import '../../domain/entity/repository_entity.dart';

class RepositoryMapper {
  static RepositoryEntity toEntity(RepositoryDto dto) {
    return RepositoryEntity(
      name: dto.name,
      format: dto.format,
      type: dto.type,
      url: dto.url,
      size: dto.size,
      attributes: dto.attributes,
    );
  }

  static List<RepositoryEntity> toEntityList(List<RepositoryDto> dtos) {
    return dtos.map((dto) => toEntity(dto)).toList();
  }
}

