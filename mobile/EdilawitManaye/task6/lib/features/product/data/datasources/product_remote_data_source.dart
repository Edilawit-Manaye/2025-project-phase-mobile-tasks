import '../models/product_model.dart';

// This is the CONTRACT for any remote data source.
// It defines what actions it must be able to perform.
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}