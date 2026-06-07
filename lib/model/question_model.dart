import 'user_model.dart'; // 📂 Imports your UserModel to handle creator profiles!

class QuestionModel {
  final int id;
  final String? content;
  final int likesCount;
  final int answersCount;
  final bool isLiked;
  final UserModel? user; //Join to user model
  final List<String> tags; // Store tags

  QuestionModel({
    required this.id,
    this.content,
    required this.likesCount,
    required this.answersCount,
    required this.isLiked,
    this.user,
    required this.tags,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      content: json['content'],
      likesCount: json['likes_count'] ?? 0,
      answersCount: json['answers_count'] ?? 0,
      isLiked: json['is_liked'] ?? false, 
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      // Loops through the tags table array and extracts just the 'name' string column
      tags: json['tags'] != null
          ? List<String>.from(json['tags'].map((tag) => tag['name'].toString()))
          : [],
    );
  }
}