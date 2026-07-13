import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

// This use case now correctly implements the generic UseCase with the Failure type.
class ViewAllProductsUsecase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  // The return type now matches the repository's contract.
  @override
  Future<(Failure?, List<ProductEntity>)> call(NoParams params) async {
    return await repository.getProducts();
  }
}