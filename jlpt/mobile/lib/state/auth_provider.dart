import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';
import '../services/api_client.dart';
import '../services/auth_api.dart';
import '../services/content_api.dart';
import '../services/exam_api.dart';
import '../services/study_api.dart';
import '../services/token_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(ref.watch(tokenStorageProvider));
  client.onSessionExpired = () => ref.read(authProvider.notifier).logout();
  return client;
});

final dioProvider = Provider<Dio>((ref) => ref.watch(apiClientProvider).dio);

final authApiProvider = Provider<AuthApi>((ref) => AuthApi(ref.watch(dioProvider)));
final contentApiProvider = Provider<ContentApi>((ref) => ContentApi(ref.watch(dioProvider)));
final examApiProvider = Provider<ExamApi>((ref) => ExamApi(ref.watch(dioProvider)));
final studyApiProvider = Provider<StudyApi>((ref) => StudyApi(ref.watch(dioProvider)));

class AuthState {
  final AppUser? user;
  final bool isRestoring;
  final String? errorMessage;

  AuthState({this.user, this.isRestoring = true, this.errorMessage});

  bool get isAuthenticated => user != null;

  AuthState copyWith({AppUser? user, bool clearUser = false, bool? isRestoring, String? errorMessage}) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isRestoring: isRestoring ?? this.isRestoring,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future.microtask(_restoreSession);
    return AuthState(isRestoring: true);
  }

  Future<void> _restoreSession() async {
    final storage = ref.read(tokenStorageProvider);
    final token = await storage.getAccessToken();
    final user = token != null ? await storage.getUser() : null;
    state = AuthState(user: user, isRestoring: false);
  }

  Future<void> login(String email, String password) async {
    final result = await ref.read(authApiProvider).login(email: email, password: password);
    await ref.read(tokenStorageProvider).saveSession(result.accessToken, result.refreshToken, result.user);
    state = AuthState(user: result.user, isRestoring: false);
  }

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required String targetLevel,
  }) async {
    final result = await ref.read(authApiProvider).register(
          email: email,
          password: password,
          displayName: displayName,
          targetLevel: targetLevel,
        );
    await ref.read(tokenStorageProvider).saveSession(result.accessToken, result.refreshToken, result.user);
    state = AuthState(user: result.user, isRestoring: false);
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearSession();
    state = AuthState(user: null, isRestoring: false);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class SelectedLevelNotifier extends Notifier<String> {
  @override
  String build() {
    Future.microtask(_restore);
    return 'N5';
  }

  Future<void> _restore() async {
    state = await ref.read(tokenStorageProvider).getSelectedLevel();
  }

  Future<void> setLevel(String level) async {
    state = level;
    await ref.read(tokenStorageProvider).setSelectedLevel(level);
  }
}

final selectedLevelProvider = NotifierProvider<SelectedLevelNotifier, String>(SelectedLevelNotifier.new);
