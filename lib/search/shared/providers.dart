import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/core/shared/providers.dart';
import 'package:repoviewer/search/application/search_history_notifier.dart';
import 'package:repoviewer/search/infrastructure/search_history_repository.dart';

final searchHistoryRepositoryProvider = Provider((ref) {
  return SearchHistoryRepository(ref.watch(sembastProvider));
});

final searchHistoryNotifierProvider = StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<String>>>((ref) {
  return SearchHistoryNotifier(ref.watch(searchHistoryRepositoryProvider));
});
