class User {
  int id;
  String username;
  String token;
  String role;

  User({
    required this.id,
    required this.username,
    required this.token,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] != null ? json['id'] as int : 0,
      username: json['username'] ?? '',
      token: json['token'] ?? '',
      role: json['role'] ?? 'user',
    );
  }
}
