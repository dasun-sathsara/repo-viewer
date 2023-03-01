import '../../../core/domain/github_repo.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

extension DTOListTODomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
