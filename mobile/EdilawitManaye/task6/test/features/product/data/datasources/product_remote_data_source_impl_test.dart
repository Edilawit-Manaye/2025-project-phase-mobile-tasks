import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:task6/core/error/exceptions.dart';
import 'package:task6/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:task6/features/product/data/models/product_model.dart';
import 'mock_http_client.dart'; // Import our new manual mock

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProducts', () {
    // This is the expected list of models we get from the sample JSON
    final tProductModelList = [
      ProductModel(id: 1, title: 'Test Product', description: 'desc', price: 10.0, rating: 4.5, imagePath: 'path', category: 'cat')
    ];
    // This is a sample successful JSON response from the server
    final tSuccessResponse = '{"data": [{"id": 1, "title": "Test Product", "description": "desc", "price": 10.0, "rating": 4.5, "imagePath": "path", "category": "cat"}]}';

    test(
      'should perform a GET request on a URL with application/json header',
          () async {
        // arrange
        mockHttpClient.responseToReturn = tSuccessResponse;
        mockHttpClient.statusCodeToReturn = 200;
        // act
        await dataSource.getProducts();
        // assert
        expect(mockHttpClient.lastCalledUrl, Uri.parse('$baseUrl/products'));
        expect(mockHttpClient.lastCalledHeaders, {'Content-Type': 'application/json'});
      },
    );

    test(
      'should return a list of ProductModels when the response code is 200 (success)',
          () async {
        // arrange
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
        mockHttpClient.statusCodeToReturn = 404; // Simulate an error
        // act
        final call = dataSource.getProducts;
        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}