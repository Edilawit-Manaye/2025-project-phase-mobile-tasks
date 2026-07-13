import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

// Note: We create a specific Params class for this use case for clarity.
class ViewProductParams {
  final String id;
  ViewProductParams(this.id);
}

class ViewProductUsecase implements UseCase<ProductEntity?, ViewProductParams> {
  final ProductRepository repository;

  ViewProductUsecase(this.repository);

  @override
  Future<(Failure?, ProductEntity?)> call(ViewProductParams params) async {
    return await repository.getProductById(params.id);
  }
}