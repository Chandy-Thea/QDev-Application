class UserModel {
  final int id;
  final String name;
  // Nullable data
  final String? email;
  final String? aboutMe;
  final String? profileUrl;
  final int? questionsCount;
  final int? answersCount;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.aboutMe,
    this.profileUrl,
    this.questionsCount,
    this.answersCount,
  });

  // Convert data from json, We use return (After convert to user class, it also reuturn them into list)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'], 
      aboutMe: json['about_me'],
      profileUrl: json['profile_url'],
      questionsCount: json['questions_count'],
      answersCount: json['answers_count'],
    );
  }
}