import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;
  DeleteProductUsecase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteProduct(id);
  }
}