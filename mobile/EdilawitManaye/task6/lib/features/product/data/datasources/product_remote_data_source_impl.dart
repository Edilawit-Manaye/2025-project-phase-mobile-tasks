import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/strings.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;
  final String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1';

  ProductRemoteDataSourceImpl({required this.client, required this.secureStorage});

  Future<Map<String, String>> _getHeaders() async {
    final token = await secureStorage.read(key: SECURE_STORAGE_TOKEN_KEY);
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse('$_baseUrl/products'),
      headers: await _getHeaders(),
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<dynamic> jsonList = responseBody['data'];
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/products/$id'),
      headers: await _getHeaders(),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/products'),
      headers: await _getHeaders(),
      // THIS IS THE CORRECTED PART:
      // We now call toJson and tell it to exclude the ID for the create operation.
      body: json.encode(product.toJson(excludeId: true)),
    );
    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse('$_baseUrl/products/${product.id}'),
      headers: await _getHeaders(),
      // For update, we do NOT exclude the id.
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('$_baseUrl/products/$id'),
      headers: await _getHeaders(),
    );
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw ServerException();
    }
  }
}