import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase {
  final ProductRepository repository;
  ViewProductUsecase(this.repository);

  Future<ProductEntity> call(int id) async {
    return await repository.getProductById(id);
  }
}