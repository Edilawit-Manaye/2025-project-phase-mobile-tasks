import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

// Note: We create a specific Params class for this use case as well.
class DeleteProductParams {
  final String id;
  DeleteProductParams(this.id);
}

class DeleteProductUsecase implements UseCase<void, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<(Failure?, void)> call(DeleteProductParams params) async {
    return await repository.deleteProduct(params.id);
  }
}