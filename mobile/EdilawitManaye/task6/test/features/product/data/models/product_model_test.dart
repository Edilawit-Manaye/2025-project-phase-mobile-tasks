import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:task6/features/product/data/models/product_model.dart';
import 'package:task6/features/product/domain/entities/product_entity.dart';

void main() {
  final tProductModel = ProductModel(
    id: 1,
    title: 'Test Shoe',
    description: 'A test description.',
    imagePath: 'images/test.jpg',
    category: 'Test Category',
    price: 99.99,
    rating: 4.5,
  );

  test(
    'should be a subclass of Product entity',
        () async {
      // assert
      expect(tProductModel, isA<ProductEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model from a JSON map',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode('{"id": 1, "title": "Test Shoe", "description": "A test description.", "imagePath": "images/test.jpg", "category": "Test Category", "price": 99.99, "rating": 4.5}');
        // act
        final result = ProductModel.fromJson(jsonMap);
        // assert
        expect(result, tProductModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = tProductModel.toJson();
        // assert
        final expectedMap = {
          "id": 1,
          "title": "Test Shoe",
          "description": "A test description.",
          "imagePath": "images/test.jpg",
          "category": "Test Category",
          "price": 99.99,
          "rating": 4.5
        };
        expect(result, expectedMap);
      },
    );
  });
}