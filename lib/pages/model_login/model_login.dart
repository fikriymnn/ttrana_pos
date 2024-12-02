class User {
  final String role;
  final String username;

  User({required this.username, required this.role});

  factory User.fromjson(Map<String, dynamic> json) {
    if (json['role'] == null) {
      throw Exception('Role tidak ada');
    }
    return User(role: json['role'], username: json['username']);
  }
}
