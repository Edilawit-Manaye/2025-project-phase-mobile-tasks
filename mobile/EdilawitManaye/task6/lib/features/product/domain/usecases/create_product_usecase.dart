import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
class CreateProductUsecase {
  final ProductRepository repository;
  CreateProductUsecase(this.repository);
  Future<void> call(ProductEntity product) async {
    return await repository.createProduct(product);
  }
}