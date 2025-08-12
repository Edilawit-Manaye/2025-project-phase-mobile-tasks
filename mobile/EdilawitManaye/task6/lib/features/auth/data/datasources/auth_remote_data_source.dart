// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import '../../../../core/error/exceptions.dart';
// // import '../models/user_model.dart';
// // import '../../chat/data/datasources/chat_remote_data_source.dart'; // Add this import
// // import '../../../../service_locator.dart';
// //
// // import '../../../../core/constants/strings.dart';
// // abstract class AuthDataSource {
// //   Future<String> login(String email, String password);
// //   Future<UserModel> signup(String name, String email, String password);
// //   Future<void> logout();
// //   Future<String?> getAuthToken();
// // }
// //
// // class AuthDataSourceImpl implements AuthDataSource {
// //   final http.Client client;
// //   final FlutterSecureStorage secureStorage;
// //   final String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2';
// //   AuthDataSourceImpl({required this.client, required this.secureStorage});
// //
// //   @override
// //   Future<String> login(String email, String password) async {
// //     final response = await client.post(
// //       Uri.parse('$_baseUrl/auth/login'),
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode({'email': email, 'password': password}),
// //     );
// //     if (response.statusCode == 201) {
// //       final token = json.decode(response.body)['data']['access_token'];
// //       await secureStorage.write(key: SECURE_STORAGE_TOKEN_KEY, value: token);
// //       sl<ChatRemoteDataSource>().initSocket(token);
// //       return token;
// //     } else {
// //       throw ServerException();
// //     }
// //   }
// //
// //   @override
// //   Future<UserModel> signup(String name, String email, String password) async {
// //     final response = await client.post(
// //       Uri.parse('$_baseUrl/auth/register'),
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode({'name': name, 'email': email, 'password': password}),
// //     );
// //     if (response.statusCode == 201) {
// //       return UserModel.fromJson(json.decode(response.body)['data']);
// //     } else {
// //       throw ServerException();
// //     }
// //   }
// //
// //   @override
// //   Future<void> logout() async {
// //     await secureStorage.delete(key: SECURE_STORAGE_TOKEN_KEY);
// //   }
// //
// //   @override
// //   Future<String?> getAuthToken() async {
// //     return await secureStorage.read(key: SECURE_STORAGE_TOKEN_KEY);
// //   }
// // }
//
//
//
//
//
//
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../../../../core/constants/strings.dart';
// import '../../../../core/error/exceptions.dart';
// import '../../../chat/data/datasources/chat_remote_data_source.dart'; // <-- Import the ABSTRACT contract
// import '../../../../service_locator.dart'; // <-- Import the service locator
// import '../models/user_model.dart';
// import '../models/user_model.dart';
//
// abstract class AuthDataSource {
//   Future<String> login(String email, String password);
//   Future<UserModel> signup(String name, String email, String password);
//   Future<void> logout();
//   Future<String?> getAuthToken();
//   Future<UserModel> getMe();
// }
//
// class AuthDataSourceImpl implements AuthDataSource {
//   final http.Client client;
//   final FlutterSecureStorage secureStorage;
//   final String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2';
//
//   AuthDataSourceImpl({required this.client, required this.secureStorage});
//
//   @override
//   Future<String> login(String email, String password) async {
//     final response = await client.post(
//       Uri.parse('$_baseUrl/auth/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'email': email, 'password': password}),
//     );
//
//     if (response.statusCode == 201) {
//       final token = json.decode(response.body)['data']['access_token'];
//       await secureStorage.write(key: SECURE_STORAGE_TOKEN_KEY, value: token);
//
//       // THIS IS THE CORRECTED PART
//       // Use the service locator to get the ChatRemoteDataSource and initialize it.
//       // We are depending on the abstract contract, not the implementation.
//       sl<ChatRemoteDataSource>().initSocket(token);
//
//       return token;
//     } else {
//       throw ServerException();
//     }
//   }
//
//
//
//   @override
//   Future<UserModel> getMe() async {
//     final token = await getAuthToken();
//     final response = await client.get(
//       Uri.parse('$_baseUrl/users/me'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return UserModel.fromJson(json.decode(response.body)['data']);
//     } else {
//       throw ServerException();
//     }
//   }
// // ... other methods
// }
//
//   @override
//   Future<UserModel> signup(String name, String email, String password) async {
//     final response = await client.post(
//       Uri.parse('$_baseUrl/auth/register'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'name': name, 'email': email, 'password': password}),
//     );
//     if (response.statusCode == 201) {
//       // Also init socket on signup
//       final token = json.decode(response.body)['data']['access_token']; // Assuming signup returns a token
//       await secureStorage.write(key: SECURE_STORAGE_TOKEN_KEY, value: token);
//       sl<ChatRemoteDataSource>().initSocket(token);
//       return UserModel.fromJson(json.decode(response.body)['data']['user']); // Assuming user is nested
//     } else {
//       throw ServerException();
//     }
//   }
//
//   @override
//   Future<void> logout() async {
//     // Also dispose of the socket on logout
//     sl<ChatRemoteDataSource>().disposeSocket();
//     await secureStorage.delete(key: SECURE_STORAGE_TOKEN_KEY);
//   }
//
//   @override
//   Future<String?> getAuthToken() async {
//     return await secureStorage.read(key: SECURE_STORAGE_TOKEN_KEY);
//   }
// }




import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

// First, the abstract "contract"
abstract class AuthDataSource {
  Future<String> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
  Future<UserModel> getMe();
  Future<void> logout();
  Future<String?> getAuthToken();
}

// Second, the concrete "implementation" of that contract
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
      // After signup, we should immediately log in to get a token
      await login(email, password);
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getMe() async {
    final token = await getAuthToken();
    final response = await client.get(
      Uri.parse('$_baseUrl/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
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