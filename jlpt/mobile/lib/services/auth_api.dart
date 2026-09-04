import 'package:dio/dio.dart';

import '../models/auth.dart';

class AuthApi {
  final Dio dio;
  AuthApi(this.dio);

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String displayName,
    required String targetLevel,
  }) async {
    final response = await dio.post('/api/auth/register', data: {
      'email': email,
      'password': password,
      'displayName': displayName,
      'targetLevel': targetLevel,
    });
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> login({required String email, required String password}) async {
    final response = await dio.post('/api/auth/login', data: {
      'email': email,
      'password': password,
    });
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
