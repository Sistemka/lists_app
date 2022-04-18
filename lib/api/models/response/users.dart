class UserPreview {
  final String id;
  final String? name;
  final String? profilePicture;

  const UserPreview({
    required this.id,
    required this.name,
    required this.profilePicture,
  });

  factory UserPreview.fromJson(Map<String, dynamic> json) {
    return UserPreview(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture'],
    );
  }
}
