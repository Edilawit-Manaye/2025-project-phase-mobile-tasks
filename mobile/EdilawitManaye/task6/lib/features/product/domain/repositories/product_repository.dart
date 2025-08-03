import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';

// The contract now correctly defines the return types.
abstract class ProductRepository {
  // This will return EITHER a Failure OR a List of products.
  Future<(Failure?, List<ProductEntity>)> getProducts();

  // This will return EITHER a Failure OR a single ProductEntity.
  Future<(Failure?, ProductEntity?)> getProductById(int id);

  // These will return EITHER a Failure OR nothing (void).
  Future<(Failure?, void)> createProduct(ProductEntity product);
  Future<(Failure?, void)> updateProduct(ProductEntity product);
  Future<(Failure?, void)> deleteProduct(int id);
}