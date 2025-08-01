import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase {
  final ProductRepository repository;
  ViewAllProductsUsecase(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getProducts();
  }
}