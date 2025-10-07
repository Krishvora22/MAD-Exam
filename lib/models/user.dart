class User {
  final String id;
  final String name;
  final String email;
  String? password;  // Optional in responses
  final String createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',  // Handle both _id and id formats
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['createdAt'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}