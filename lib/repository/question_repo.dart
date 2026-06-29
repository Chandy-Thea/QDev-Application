// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class QuestionRepo {
  final baseUrl = 'http://192.168.1.7:8000/api';
  final storage = FlutterSecureStorage();

  Future<List<dynamic>?> getQuestions(String filter) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.get(Uri.parse('$baseUrl/questions?filter=$filter'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    });

    print(response.statusCode);
    if(response.statusCode == 200){
      final data = json.decode(response.body)['data']['data'];
      return data;
    }else {
      return null;
    }
  }

  Future<List<dynamic>?> getMyQuestions() async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.get(Uri.parse('$baseUrl/my-questions'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    });

    print(response.statusCode);
    if(response.statusCode == 200){
      final data = json.decode(response.body)['data'];
      return data;
    }else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getAnswer(int id) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.get(Uri.parse('$baseUrl/questions/$id'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    });

    print(response.statusCode);
    if(response.statusCode == 200){
      final data = json.decode(response.body)['data'];
      return data;
    }else {
      return null;
    }
  }

  Future<List<dynamic>?> searchQuery(String query) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.get(Uri.parse('$baseUrl/search?query=$query'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    });

    print(response.statusCode);
    if(response.statusCode == 200){
      //Get list of data
      final data = json.decode(response.body)['data']['data'];
      return data;
    }else {
      return null;
    }
  }

  Future<String?> postAnswer(int id, String answerText) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.post(Uri.parse('$baseUrl/questions/$id/answers'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    },
    body: json.encode({
      'answer_text': answerText,
    }));

    print(response.statusCode);
    if(response.statusCode == 200){
      final message = json.decode(response.body)['message']; // Get success message
      return message;
    }else {
      final message = json.decode(response.body)['message']; // Get fail message
      return message;
    }
  }

  Future<String?> postQuestion(String questionText, List<String> tags) async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.post(Uri.parse('$baseUrl/questions'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    },
    body: json.encode({
      'question_text': questionText,
      'tags': tags
    }));

    print(response.statusCode);
    if(response.statusCode == 200){
      final message = json.decode(response.body)['message']; // Get success message
      return message;
    }else {
      final message = json.decode(response.body)['message']; // Get fail message
      return message;
    }
  }

  Future<List<dynamic>?> getTags() async {
    final String? bearerToken = await storage.read(key: 'auth_token');
    print(bearerToken);
    if (bearerToken == null){
      print('Bearer is null!!');
      return null;
    }

    final response = await http.get(Uri.parse('$baseUrl/tags'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    },);

    print(response.statusCode);
    if(response.statusCode == 200){
      // Get list of tags
      final rawList = json.decode(response.body)['data'];
      return rawList;
    }else {
      return null;
    }
  }
}