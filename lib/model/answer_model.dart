import 'user_model.dart';

class AnswerModel {
  final int id;
  final int questionId;
  final String answerText;
  final int likesCount;
  final DateTime createdAt;
  final UserModel? user; // The user who wrote this specific answer

  const AnswerModel({
    required this.id,
    required this.questionId,
    required this.answerText,
    required this.likesCount,
    required this.createdAt,
    this.user,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] ?? 0,
      questionId: json['question_id'] ?? 0,
      answerText: json['answer_text'] ?? 'No content provided',
      likesCount: json['likes_count'] ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}