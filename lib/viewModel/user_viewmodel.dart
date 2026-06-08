import 'package:flutter/material.dart';
import 'package:q_dev_app/model/user_model.dart';
import 'package:q_dev_app/repository/user_repo.dart';

class UserViewmodel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepo();

  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _user;

  // Getters to expose these states to the View safely
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user; // Store user info

  Future<void> fetchUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final map = await _userRepo.getUserInfo();
      
      if (map != null) {
        // Store data to _user variable
        _user = UserModel.fromJson(map);
      } else {
        _errorMessage = "No user data found.";
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to load user info: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}