import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/github/core/domain/github_failure.dart';
import 'package:repoviewer/github/detail/domain/github_repo_detail.dart';
import 'package:repoviewer/github/detail/infrastructure/repo_detail_repository.dart';

import '../../../core/domain/fresh.dart';

part 'repo_detail_notifier.freezed.dart';

@freezed
class RepoDetailState with _$RepoDetailState {
  const RepoDetailState._();

  const factory RepoDetailState.initial({@Default(false) bool hasStarredStatusChanged}) = _Initial;

  const factory RepoDetailState.loadInProgress({@Default(false) bool hasStarredStatusChanged}) = _LoadInProgress;

  const factory RepoDetailState.loadSuccess(Fresh<GithubRepoDetail?> repoDetail,
      {@Default(false) bool hasStarredStatusChanged}) = _LoadSuccess;

  const factory RepoDetailState.loadFailure(GithubFailure failure, {@Default(false) bool hasStarredStatusChanged}) =
      _LoadFailure;
}

class RepoDetailNotifier extends StateNotifier<RepoDetailState> {
  final RepoDetailRepository _repository;

  RepoDetailNotifier(this._repository) : super(const RepoDetailState.initial());

  Future<void> getRepoDetail(String fullRepoName) async {
    state = const RepoDetailState.loadInProgress();

    final failureOrRepoDetail = await _repository.getRepoDetail(fullRepoName);

    state = failureOrRepoDetail.fold((l) => RepoDetailState.loadFailure(l), (r) => RepoDetailState.loadSuccess(r));
  }

  Future<void> switchStarredStatus(GithubRepoDetail repoDetail) async {
    state.maybeMap(
      orElse: () {},
      loadSuccess: (successState) async {
        final oldState = successState.copyWith();
        final repoDetail = successState.repoDetail.entity;

        if (repoDetail != null) {
          state = successState.copyWith.repoDetail(entity: repoDetail.copyWith(starred: !repoDetail.starred));

          final failureOrSuccess = await _repository.switchStarredStatus(repoDetail);

          state = failureOrSuccess.fold(
            (l) => state = oldState,
            (r) => r == null ? state = oldState : state = state.copyWith(hasStarredStatusChanged: true),
          );
        }
      },
    );
  }
}
