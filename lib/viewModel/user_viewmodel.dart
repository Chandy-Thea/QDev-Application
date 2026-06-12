import 'package:flutter/material.dart';
import 'package:q_dev_app/model/user_model.dart';
import 'package:q_dev_app/repository/user_repo.dart';

class UserViewmodel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepo();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  UserModel? _user;

  // Getters to expose these states to the View safely
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  UserModel? get user => _user; // Store user info

  Future<bool> register(String fullName, String email, String password, String confirmPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final bool status = await _userRepo.register(fullName, email, password, confirmPassword);
      
      if (status == true) {
        return status;
      } else {
      // Catch the error and turn it into a user-friendly message
        _errorMessage = "Something weng wrong!!";
        return status;
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to change password: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final bool status = await _userRepo.login(email, password);
      
      if (status == true) {
        return status;
      } else {
      // Catch the error and turn it into a user-friendly message
        _errorMessage = "Something weng wrong!!";
        return status;
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to change password: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logout () async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final bool status = await _userRepo.logout();
      
      if (status == true) {
        return status;
      } else {
      // Catch the error and turn it into a user-friendly message
        _errorMessage = "Something weng wrong!!";
        return status;
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to change password: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAccount() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final bool status = await _userRepo.deleteAccount();
      
      if (status == true) {
        return status;
      } else {
      // Catch the error and turn it into a user-friendly message
        _errorMessage = "Something weng wrong!!";
        return status;
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to change password: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final map = await _userRepo.getUserInfo();
      
      if (map != null) {
        // convert from map to dart data and store to _user variable
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

  Future<void> userEditProfile(String name, String aboutMe) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final map = await _userRepo.userEditProfile(name, aboutMe);
      
      if (map != null) {
        // Convert from map to dart data and update to _user variable
        _user = UserModel.fromJson(map);
      } else {
        _errorMessage = "Something weng wrong!!";
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to load user info: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final bool status = await _userRepo.changePassword(currentPassword, newPassword);
      
      if (status == true) {
        return status;
      } else {
      // Catch the error and turn it into a user-friendly message
        _errorMessage = "Something weng wrong!!";
        return status;
      }
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to change password: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> forgotPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final String message = await _userRepo.forgotPassword(email);
      return message;
    } catch (e) {
      // Catch the error and turn it into a user-friendly message
      _errorMessage = "Failed to change password: ${e.toString()}";
      return _errorMessage!;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}