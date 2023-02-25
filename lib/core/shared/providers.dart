import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/core/infrastructure/sembast_database.dart';

final sembastProvider = Provider<SembastDatabase>((ref) {
  return SembastDatabase();
});
