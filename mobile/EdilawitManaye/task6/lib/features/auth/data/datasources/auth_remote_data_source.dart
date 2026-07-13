import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

import '../../../../core/constants/strings.dart';
abstract class AuthDataSource {
  Future<String> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
  Future<void> logout();
  Future<String?> getAuthToken();
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;
  final String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2';
  AuthDataSourceImpl({required this.client, required this.secureStorage});

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      final token = json.decode(response.body)['data']['access_token'];
      await secureStorage.write(key: SECURE_STORAGE_TOKEN_KEY, value: token);
      return token;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    await secureStorage.delete(key: SECURE_STORAGE_TOKEN_KEY);
  }

  @override
  Future<String?> getAuthToken() async {
    return await secureStorage.read(key: SECURE_STORAGE_TOKEN_KEY);
  }
}