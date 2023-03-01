import '../infrastructure/searched_repos_repository.dart';
import '../../core/application/repos_notifier.dart';

class SearchedReposNotifier extends ReposNotifier {
  final SearchedRemoteRepository _repository;

  SearchedReposNotifier(this._repository);

  Future<void> getNextSearchedReposPage(String query) async {
    super.getNextPage((page) => _repository.getSearchedReposPage(query, page));
  }
}