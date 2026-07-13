import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:task6/core/error/exceptions.dart';
import 'package:task6/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:task6/features/product/data/models/product_model.dart';
import 'mock_http_client.dart';
import 'mock_secure_storage.dart'; // Import the new manual mock

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockFlutterSecureStorage mockSecureStorage; // Declare the new mock
  const String baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1';

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSecureStorage = MockFlutterSecureStorage(); // Initialize the new mock
    dataSource = ProductRemoteDataSourceImpl(
      client: mockHttpClient,
      secureStorage: mockSecureStorage, // Provide the new mock to the constructor
    );
  });

  group('getProducts', () {
    final tProductModelList = [
      ProductModel(id: "1", name: 'Test Product', description: 'desc', price: 10.0, rating: 4.5, imageUrl: 'path', category: 'cat')
    ];
    final tSuccessResponse = '{"data": [{"id": 1, "title": "Test Product", "description": "desc", "price": 10.0, "rating": 4.5, "imagePath": "path", "category": "cat"}]}';
    const tToken = 'sample_auth_token';

    test(
      'should perform a GET request on a URL with the correct Authorization header',
          () async {
        // arrange
        // Set up the mock to return a fake token
        mockSecureStorage.tokenToReturn = tToken;
        // Set up the mock http client to return a successful response
        mockHttpClient.responseToReturn = tSuccessResponse;
        mockHttpClient.statusCodeToReturn = 200;

        // act
        await dataSource.getProducts();

        // assert
        // Verify that the correct URL was called
        expect(mockHttpClient.lastCalledUrl, Uri.parse('$baseUrl/products'));
        // Verify that the headers included the correct Authorization token
        expect(mockHttpClient.lastCalledHeaders, {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tToken',
        });
      },
    );

    test(
      'should return a list of ProductModels when the response code is 200 (success)',
          () async {
        // arrange
        mockSecureStorage.tokenToReturn = tToken;
        mockHttpClient.responseToReturn = tSuccessResponse;
        mockHttpClient.statusCodeToReturn = 200;

        // act
        final result = await dataSource.getProducts();

        // assert
        expect(result, equals(tProductModelList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        mockSecureStorage.tokenToReturn = tToken;
        // Simulate a server error
        mockHttpClient.statusCodeToReturn = 404;

        // act
        final call = dataSource.getProducts;

        // assert
        // Verify that the method throws the correct exception
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });

  // Note: For a complete project, you would add similar test groups
  // for getProductById, createProduct, updateProduct, and deleteProduct
  // to ensure their headers and logic are also tested.
}