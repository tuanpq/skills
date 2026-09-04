class AppUser {
  final int userId;
  final String email;
  final String displayName;
  final String role;

  AppUser({required this.userId, required this.email, required this.displayName, required this.role});

  factory AppUser.fromAuthJson(Map<String, dynamic> json) {
    return AppUser(
      userId: json['userId'] as int,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'displayName': displayName,
        'role': role,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        userId: json['userId'] as int,
        email: json['email'] as String,
        displayName: json['displayName'] as String,
        role: json['role'] as String,
      );
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final AppUser user;

  AuthResponse({required this.accessToken, required this.refreshToken, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: AppUser.fromAuthJson(json),
    );
  }
}
