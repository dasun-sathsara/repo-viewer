import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/auth_failure.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../infrastructure/github_authenticator.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = _Initial;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

class AuthNotifier extends StateNotifier<AuthState> {
  final GithubAuthenticator _authenticator;

  AuthNotifier(this._authenticator) : super(const AuthState.initial());

  Future<void> chechAndUpdateAuthStatus() async {
    state = (await _authenticator.isSignedIn()) ? const AuthState.authenticated() : const AuthState.unauthenticated();
  }

  Future<void> signIn(AuthUriCallback authorizationCallback) async {
    final grant = _authenticator.createGrant();
    final redirectUri = await authorizationCallback(_authenticator.getAuthorizationUrl(grant));
    final failureOrSuccess = await _authenticator.handleAutorizationResponse(grant, redirectUri.queryParameters);

    state = failureOrSuccess.fold((l) => AuthState.failure(l), (r) => const AuthState.authenticated());
    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();
    state = failureOrSuccess.fold((l) => AuthState.failure(l), (r) => const AuthState.unauthenticated());
  }
}
