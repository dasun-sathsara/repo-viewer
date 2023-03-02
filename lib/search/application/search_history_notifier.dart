import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../infrastructure/search_history_repository.dart';

class SearchHistoryNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final SearchHistoryRepository _repository;

  SearchHistoryNotifier(this._repository) : super(const AsyncValue.loading());

  void watchSearchTerms({String? filter}) {
    _repository.watchSearchTerms(filter: filter).listen((data) {
      state = AsyncValue.data(data);
    }, onError: (Object error) {
      state = AsyncValue.error(error, StackTrace.current);
    });
  }

  Future<void> addSearchTerm(String term) async => _repository.addSearchTerm(term);

  Future<void> deleteSearchTerm(String term) async => _repository.deleteSearchTerm(term);

  Future<void> putSearchTermFirst(String term) async => _repository.putSearchTermFirst(term);
}
