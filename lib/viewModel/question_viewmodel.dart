import 'package:flutter/material.dart';
import 'package:q_dev_app/model/question_model.dart';
import 'package:q_dev_app/repository/question_repo.dart';

class QuestionViewmodel extends ChangeNotifier {
  final QuestionRepo _questionRepo = QuestionRepo();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  List<QuestionModel>? _question;

  // Getters to expose these states to the View safely
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  List<QuestionModel>? get question => _question; // Store question info

  Future<void> fetchQuestions(String filter) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final rawList = await _questionRepo.getQuestions(filter);
      
      if (rawList != null) {
      // Access to jsondata (jsonItem) then return back as QuestionModel
      _question = rawList.map((jsonItem) => QuestionModel.fromJson(jsonItem)).toList();
    } else {
        _errorMessage = "No question data found.";
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to load question: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}