import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/fresh.dart';
import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import '../../../core/infrastructure/pagination_config.dart';

part 'repos_notifier.freezed.dart';

typedef RepositoryGetter = Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> Function(int page);

@freezed
class ReposState with _$ReposState {
  const ReposState._();
  const factory ReposState.initial(Fresh<List<GithubRepo>> repos) = _Initial;
  const factory ReposState.loadInProgress(
    Fresh<List<GithubRepo>> repos,
    int itemsPerPage,
  ) = _LoadInProgress;
  const factory ReposState.loadSuccess(
    Fresh<List<GithubRepo>> repos, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;
  const factory ReposState.loadFailure(
    Fresh<List<GithubRepo>> repos,
    GithubFailure failure,
  ) = _LoadFailure;
}

class ReposNotifier extends StateNotifier<ReposState> {
  ReposNotifier() : super(ReposState.initial(Fresh.yes([])));

  int _page = 1;

  @protected
  void resetState() {
    _page = 1;
    state = ReposState.initial(Fresh.yes([]));
  }

  @protected
  Future<void> getNextPage(RepositoryGetter getter) async {
    state = ReposState.loadInProgress(state.repos, PaginationConfig.itemsPerPage);

    final failureOrRepos = await getter(_page);

    state = failureOrRepos.fold(
      (l) => state = ReposState.loadFailure(state.repos, l),
      (r) {
        _page++;
        return ReposState.loadSuccess(r.copyWith(entity: [...state.repos.entity, ...r.entity]),
            isNextPageAvailable: r.isNextPageAvailable ?? false);
      },
    );
  }
}
