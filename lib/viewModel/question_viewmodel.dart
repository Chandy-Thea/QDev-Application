import 'package:flutter/material.dart';
import 'package:q_dev_app/model/question_model.dart';
import 'package:q_dev_app/repository/question_repo.dart';

class QuestionViewmodel extends ChangeNotifier {
  final QuestionRepo _questionRepo = QuestionRepo();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  final Map<String, List<QuestionModel>> _question = {};

  // Getters to expose these states to the View safely
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  List<QuestionModel>? getQuestion(String filter) => _question[filter]; // For return to UI

  Future<void> fetchQuestions(String filter) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final rawList = await _questionRepo.getQuestions(filter);
      
      if (rawList != null) {
      // Access to jsondata (jsonItem) then return back as QuestionModel
      final parsedQuestions = rawList.map((jsonItem) => QuestionModel.fromJson(jsonItem)).toList();
      // Save to _question
      _question[filter] = parsedQuestions;
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