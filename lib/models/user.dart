class User {
  final String id;
  final String name;
  final String email;
  final String? profileImagePath;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImagePath,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImagePath': profileImagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImagePath: map['profileImagePath'] as String?,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : DateTime.now(),
    );
  }

  String toJson() => toMap().toString();

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
