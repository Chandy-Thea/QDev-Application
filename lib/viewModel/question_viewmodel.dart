import 'package:flutter/material.dart';
import 'package:q_dev_app/model/question_model.dart';
import 'package:q_dev_app/repository/question_repo.dart';

class QuestionViewmodel extends ChangeNotifier {
  final QuestionRepo _questionRepo = QuestionRepo();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  final Map<String, List<QuestionModel>> _question = {};
  List<QuestionModel>? _myQuestion;
  QuestionModel? _selectedQuestion; //For specific question with their answers

  // Getters to expose these states to the View safely
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  List<QuestionModel>? getQuestion(String filter) => _question[filter]; // For return to UI
  List<QuestionModel>? get myQuestion => _myQuestion;
  QuestionModel? get selectedQuestion => _selectedQuestion;

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

  Future<void> fetchMyQuestions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final rawList = await _questionRepo.getMyQuestions();
      
      if (rawList != null) {
      // Access to jsondata (jsonItem) then return back as QuestionModel
      _myQuestion = rawList.map((jsonItem) => QuestionModel.fromJson(jsonItem)).toList();
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

  // Fetch specific question with answers for (Answer Screen)
  Future<void> fetchAnswer(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final map = await _questionRepo.getAnswer(id);
      
      if (map != null) {
      // Access to jsondata (jsonItem) then return back as QuestionModel
      _selectedQuestion = QuestionModel.fromJson(map);
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