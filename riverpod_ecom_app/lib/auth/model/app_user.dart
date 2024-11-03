class AppUser {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final bool? isDeleted;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.isDeleted,
  });
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      isDeleted: map['isDeleted'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'isDeleted': isDeleted,
    };
  }
}
