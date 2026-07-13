import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class CreateProductUsecase implements UseCase<void, ProductEntity> {
  final ProductRepository repository;

  CreateProductUsecase(this.repository);

  @override
  Future<(Failure?, void)> call(ProductEntity params) async {
    // The 'params' in this case is the product to be created.
    return await repository.createProduct(params);
  }
}