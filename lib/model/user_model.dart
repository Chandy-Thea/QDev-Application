class UserModel {
  final int id;
  final String name;
  final String email;
  // Nullable data
  final String? aboutMe;
  final String? profileUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.aboutMe,
    this.profileUrl,
  });

  // Convert data from json, We use return (After convert to user class, it also reuturn them into list)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'] ?? '', // Safeguards against any parsing errors
      aboutMe: json['about_me'],
      profileUrl: json['profile_url'],
    );
  }
}