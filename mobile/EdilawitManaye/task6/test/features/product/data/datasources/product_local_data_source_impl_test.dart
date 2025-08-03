import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task6/core/error/exceptions.dart';
import 'package:task6/features/product/data/datasources/product_local_data_source_impl.dart';
import 'package:task6/features/product/data/models/product_model.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;

  // Use the helper from the package to mock SharedPreferences
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    dataSource = ProductLocalDataSourceImpl();
  });

  final tProductModelList = [
    ProductModel(id: 1, title: 'Test Product', description: 'desc', imagePath: 'path', category: 'cat', price: 1.0, rating: 1.0),
  ];
  final tProductListJson = json.encode(tProductModelList.map((p) => p.toJson()).toList());

  group('getLastProducts', () {
    test(
      'should return ProductModels from SharedPreferences when there is one in the cache',
          () async {
        // arrange
        // Set the mock values before the test runs
        SharedPreferences.setMockInitialValues({CACHED_PRODUCTS_KEY: tProductListJson});
        dataSource = ProductLocalDataSourceImpl(); // Re-initialize to use the new mock values

        // act
        final result = await dataSource.getLastProducts();

        // assert
        expect(result, equals(tProductModelList));
      },
    );

    test(
      'should throw a CacheException when there is not a cached value',
          () async {
        // arrange
        SharedPreferences.setMockInitialValues({});
        dataSource = ProductLocalDataSourceImpl(); // Re-initialize with empty values

        // act
        final call = dataSource.getLastProducts;

        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheProducts', () {
    test(
      'should call SharedPreferences to cache the data',
          () async {
        // act
        await dataSource.cacheProducts(tProductModelList);
        // assert
        final prefs = await SharedPreferences.getInstance();
        final cachedValue = prefs.getString(CACHED_PRODUCTS_KEY);
        expect(cachedValue, equals(tProductListJson));
      },
    );
  });
}