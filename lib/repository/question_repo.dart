// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class QuestionRepo {
  final baseUrl = 'http://192.168.1.14:8000/api';
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
}