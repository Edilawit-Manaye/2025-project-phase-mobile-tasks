import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase implements UseCase<void, ProductEntity> {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  @override
  Future<(Failure?, void)> call(ProductEntity params) async {
    // The 'params' here is the product with the updated information.
    return await repository.updateProduct(params);
  }
}