import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/auth_notifier.dart';
import '../infrastructure/credentials_storage/credentials_storage.dart';
import '../infrastructure/credentials_storage/secure_credentials_storage.dart';
import '../infrastructure/github_authenticator.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final credentialStorageProvider = Provider<CredentialStorage>((ref) {
  return SecureCredentialStorage(ref.watch(secureStorageProvider));
});

final githubAuthenticatorProvider = Provider<GithubAuthenticator>((ref) {
  return GithubAuthenticator(ref.watch(credentialStorageProvider), ref.watch(dioProvider));
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(githubAuthenticatorProvider));
});
