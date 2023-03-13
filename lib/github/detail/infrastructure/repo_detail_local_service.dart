import '../../../core/infrastructure/sembast_database.dart';
import '../../core/infrastructure/github_headers_cache.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

import 'github_repo_detail_dto.dart';

class RepoDetailLocalService {
  static const cacheSize = 50;

  final SembastDatabase _sembastDatabase;
  final GithubHeadersCache _headersCache;
  final _store = stringMapStoreFactory.store('repoDetails');

  RepoDetailLocalService(this._sembastDatabase, this._headersCache);

  Future<void> upsertRepoDetail(GithubRepoDetailDto githubRepoDetailDto) async {
    await _store.record(githubRepoDetailDto.fullName).put(_sembastDatabase.instance, githubRepoDetailDto.toSembast());

    final keys = await _store.findKeys(
      _sembastDatabase.instance,
      finder: Finder(
        sortOrders: [SortOrder(GithubRepoDetailDto.lastUsedFieldName, false)],
      ),
    );

    if (keys.length > cacheSize) {
      final keysToRemove = keys.sublist(cacheSize);
      for (final key in keysToRemove) {
        await _store.record(key).delete(_sembastDatabase.instance);
        await _headersCache.deleteHeaders(
          Uri.https('api.github.com', '/user/starred/$key'),
        );
      }
    }
  }

  Future<GithubRepoDetailDto?> getRepoDetail(String fullRepoName) async {
    final record = _store.record(fullRepoName);
    await record.update(
      _sembastDatabase.instance,
      {GithubRepoDetailDto.lastUsedFieldName: Timestamp.now()},
    );

    final recordSnapshot = await record.getSnapshot(_sembastDatabase.instance);

    if (recordSnapshot == null) {
      return null;
    }

    return GithubRepoDetailDto.fromSembast(recordSnapshot);
  }
}
