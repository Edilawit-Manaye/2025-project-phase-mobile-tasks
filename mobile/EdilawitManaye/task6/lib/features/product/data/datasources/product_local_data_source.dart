import '../models/product_model.dart';

// This is the CONTRACT for any local data source (caching).
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}