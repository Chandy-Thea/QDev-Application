import 'package:q_dev_app/model/answer_model.dart';

import 'user_model.dart';

class QuestionModel {
  final int id;
  final String? content;
  final int likesCount;
  final int answersCount;
  final bool isLiked;
  final UserModel? user; //Join to user model
  final List<String> tags; // Store tags
  final List<AnswerModel> answers; // For answer screen
  final DateTime createdAt;

  QuestionModel({
    required this.id,
    this.content,
    required this.likesCount,
    required this.answersCount,
    required this.isLiked,
    this.user,
    required this.tags,
    required this.answers,
    required this.createdAt
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      content: json['question_text'],
      likesCount: json['likes_count'] ?? 0,
      answersCount: json['answers_count'] ?? 0,
      isLiked: json['is_liked'] ?? false, 
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      // Loops through the tags table array and extracts just the 'name' string column
      tags: json['tags'] != null
          ? List<String>.from(json['tags'].map((tag) => tag['name'].toString()))
          : [],
      answers: json['answers'] != null
          ? (json['answers'] as List).map((item) => AnswerModel.fromJson(item)).toList()
          : [],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}