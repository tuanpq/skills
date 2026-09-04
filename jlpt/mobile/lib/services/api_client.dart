import 'package:dio/dio.dart';

import 'token_storage.dart';

const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

/// Wraps a configured [Dio] instance that attaches the JWT access token to
/// every request and transparently refreshes it once on a 401 response,
/// mirroring the interceptor in the ReactJS frontend's api/client.ts.
class ApiClient {
  final TokenStorage tokenStorage;
  late final Dio dio;

  /// Called when the refresh token is missing/invalid and the session must
  /// be cleared. Wired up to the auth provider from main.dart.
  void Function()? onSessionExpired;

  ApiClient(this.tokenStorage) {
    dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final isUnauthorized = error.response?.statusCode == 401;
          final alreadyRetried = error.requestOptions.extra['retried'] == true;

          if (isUnauthorized && !alreadyRetried) {
            try {
              final newToken = await _refreshAccessToken();
              final retryOptions = error.requestOptions;
              retryOptions.extra['retried'] = true;
              retryOptions.headers['Authorization'] = 'Bearer $newToken';
              final response = await dio.fetch(retryOptions);
              handler.resolve(response);
              return;
            } catch (_) {
              await tokenStorage.clearSession();
              onSessionExpired?.call();
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<String> _refreshAccessToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      throw StateError('No refresh token available');
    }
    final response = await Dio(BaseOptions(baseUrl: apiBaseUrl))
        .post('/api/auth/refresh', data: {'refreshToken': refreshToken});
    final data = response.data as Map<String, dynamic>;
    final user = await tokenStorage.getUser();
    if (user != null) {
      await tokenStorage.saveSession(
        data['accessToken'] as String,
        data['refreshToken'] as String,
        user,
      );
    }
    return data['accessToken'] as String;
  }
}
