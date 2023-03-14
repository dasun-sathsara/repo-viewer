import '../../core/application/repos_notifier.dart';
import '../infrastructure/starred_repos_repository.dart';

class StarredReposNotifier extends ReposNotifier {
  final StarredReposRepository _repository;
  StarredReposNotifier(this._repository);

  Future<void> getFirstStarredReposPage() async {
    super.resetState();
    await getNextStarredReposPage();
  }

  Future<void> getNextStarredReposPage() async {
    await super.getNextPage((page) => _repository.getStarredReposPage(page));
  }
}
