import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

// Now it implements the generic UseCase
class ViewAllProductsUsecase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  // The call method now correctly accepts a 'params' argument
  @override
  Future<(Failure?, List<ProductEntity>)> call(NoParams params) async {
    final products = await repository.getProducts();
    return (null, products);
  }
}