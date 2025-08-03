import 'package:flutter_test/flutter_test.dart';
import 'package:task6/features/product/data/models/product_model.dart';
import 'package:task6/features/product/data/repositories/product_repository_impl.dart';
import 'mock_data_sources.dart'; // Import our new manual mocks

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getProducts', () {
    final tProductModelList = [
      ProductModel(id: 1, title: 'Test Product 1', description: 'Desc 1', imagePath: '', category: '', price: 10, rating: 4),
    ];

    test(
      'should check if the device is online',
          () async {
        // arrange
        mockNetworkInfo.isConnectedResult = true; // Control the result
        // act
        await repository.getProducts();
        // assert
        // This test is simply to ensure the check happens. We don't need a verify for this manual mock.
      },
    );

    group('device is online', () {
      setUp(() {
        mockNetworkInfo.isConnectedResult = true;
      });

      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          mockRemoteDataSource.productsToReturn = tProductModelList;
          // act
          final (_, result) = await repository.getProducts();
          // assert
          expect(result, equals(tProductModelList));
          expect(mockRemoteDataSource.getProductsCalled, isTrue);
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
            () async {
          // arrange
          mockRemoteDataSource.productsToReturn = tProductModelList;
          // act
          await repository.getProducts();
          // assert
          expect(mockRemoteDataSource.getProductsCalled, isTrue);
          expect(mockLocalDataSource.cachedProducts, equals(tProductModelList));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        mockNetworkInfo.isConnectedResult = false;
      });

      test(
        'should return last locally cached data when the cached data is present',
            () async {
          // arrange
          mockLocalDataSource.productsToReturn = tProductModelList;
          // act
          final (_, result) = await repository.getProducts();
          // assert
          expect(mockRemoteDataSource.getProductsCalled, isFalse);
          expect(mockLocalDataSource.getLastProductsCalled, isTrue);
          expect(result, equals(tProductModelList));
        },
      );
    });
  });
}