import 'package:task6/core/network/network_info.dart';
import 'package:task6/features/product/data/datasources/product_local_data_source.dart';
import 'package:task6/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task6/features/product/data/models/product_model.dart';

// A manual mock for NetworkInfo
class MockNetworkInfo implements NetworkInfo {
  bool isConnectedResult = true; // Control the result from your test
  @override
  Future<bool> get isConnected => Future.value(isConnectedResult);
}

// A manual mock for the Remote Data Source
class MockProductRemoteDataSource implements ProductRemoteDataSource {
  List<ProductModel>? productsToReturn;
  bool getProductsCalled = false;

  @override
  Future<List<ProductModel>> getProducts() async {
    getProductsCalled = true;
    return Future.value(productsToReturn ?? []);
  }

  // We don't need to implement the other methods for this test
  @override
  Future<void> createProduct(ProductModel product) async {}
  @override
  Future<void> deleteProduct(int id) async {}
  @override
  Future<ProductModel> getProductById(int id) async => throw UnimplementedError();
  @override
  Future<void> updateProduct(ProductModel product) async {}
}

// A manual mock for the Local Data Source
class MockProductLocalDataSource implements ProductLocalDataSource {
  List<ProductModel>? productsToReturn;
  bool getLastProductsCalled = false;
  List<ProductModel>? cachedProducts;

  @override
  Future<List<ProductModel>> getLastProducts() async {
    getLastProductsCalled = true;
    return Future.value(productsToReturn ?? []);
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    cachedProducts = products;
  }
}