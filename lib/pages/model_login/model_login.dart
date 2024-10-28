class User {
  final String role;

  User({required this.role});

  factory User.fromjson(Map<String, dynamic> json) {
    if (json['role'] == null) {
      throw Exception('Role tidak ada');
    }
    return User(role: json['role']);
  }
}
