// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepo {
  final baseUrl = 'http://192.168.1.15:8000/api';
  final storage = FlutterSecureStorage();

  Future<bool> register(String fullName, String email, String password, String confirmPassword) async {
    final response = await http.post(Uri.parse('$baseUrl/register'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: json.encode({
      'name': fullName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword
    }));

    print(response.statusCode);
    if(response.statusCode == 200){
      String token = json.decode(response.body)['token'];
      await storage.write(key: 'auth_token', value: token); //Store token in storage
      return true;
    }else {
      print("Validation Errors from Server: ${response.body}");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);

    final response = await http.get(Uri.parse('$baseUrl/user/profile'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    });

    print(response.statusCode);
    if(response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      return data;
    }else {
      //Check if Token is dead
      if (response.statusCode == 401) {
        await storage.delete(key: 'auth_token');
      }
      print("Validation Errors from Server: ${response.body}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> userEditProfile(String name, String aboutMe) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);

    final response = await http.post(Uri.parse('$baseUrl/user/profile'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    },
    body: json.encode({
      'profile_file': null,
      'name': name,
      'about_me': aboutMe
    }),);

    print(response.statusCode);
    if( response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      return data;
    }else {
      print("Validation Errors from Server: ${response.body}");
      return null;
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);

    final response = await http.post(Uri.parse('$baseUrl/user/update-password'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    },
    body: json.encode({
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPassword
    }),);

    print(response.statusCode);
    if( response.statusCode == 200){
      return true;
    }else {
      print("Validation Errors from Server: ${response.body}");
      return false;
    }
  }
}