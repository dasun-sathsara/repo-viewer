import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

import '../domain/github_repo_detail.dart';

part 'github_repo_detail_dto.freezed.dart';
part 'github_repo_detail_dto.g.dart';

@freezed
class GithubRepoDetailDto with _$GithubRepoDetailDto {
  const GithubRepoDetailDto._();
  const factory GithubRepoDetailDto({
    required String fullName,
    required String html,
    required bool starred,
  }) = _GithubRepoDetailDto;

  static const lastUsedFieldName = 'lastUsed';

  factory GithubRepoDetailDto.fromJson(Map<String, dynamic> json) => _$GithubRepoDetailDtoFromJson(json);

  GithubRepoDetail toDomain() => GithubRepoDetail(fullName: fullName, html: html, starred: starred);

  Map<String, dynamic> toSembast() {
    final json = toJson();
    json.remove('fullName');
    json[lastUsedFieldName] = Timestamp.now();

    return json;
  }

  factory GithubRepoDetailDto.fromSembast(RecordSnapshot<String, Map<String, dynamic>> snapshot) {
    final copiedMap = Map<String, dynamic>.from(snapshot.value);
    copiedMap['fullName'] = snapshot.key;

    return GithubRepoDetailDto.fromJson(copiedMap);
  }
}
