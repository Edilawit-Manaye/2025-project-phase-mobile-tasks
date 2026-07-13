// Use package imports to access files in the 'lib' directory from 'test'
import 'package:task6/core/error/failures.dart';
import 'package:task6/core/usecases/usecase.dart';
import 'package:task6/features/product/domain/entities/product_entity.dart';
import 'package:task6/features/product/domain/repositories/product_repository.dart';
import 'package:task6/features/product/domain/usecases/create_product_usecase.dart';
import 'package:task6/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:task6/features/product/domain/usecases/update_product_usecase.dart';
import 'package:task6/features/product/domain/usecases/view_all_products_usecase.dart';
import 'package:task6/features/product/domain/usecases/view_product_usecase.dart';

// Create a simple mock for the repository that all the use cases need
class MockProductRepository implements ProductRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// This is the corrected mock that provides a fake repository
class MockViewAllProductsUsecase implements ViewAllProductsUsecase {
  // 1. Provide the missing 'repository' property
  @override
  final ProductRepository repository = MockProductRepository();

  // 2. Control the result from the test
  (Failure?, List<ProductEntity>)? resultToReturn;

  @override
  Future<(Failure?, List<ProductEntity>)> call(NoParams params) async {
    // CORRECT
    return Future.value(resultToReturn ?? (null, <ProductEntity>[]));
  }
}

// The other mocks just need to implement the class to satisfy the type system
class MockCreateProductUsecase implements CreateProductUsecase {
  @override
  final ProductRepository repository = MockProductRepository();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
class MockUpdateProductUsecase implements UpdateProductUsecase {
  @override
  final ProductRepository repository = MockProductRepository();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
class MockDeleteProductUsecase implements DeleteProductUsecase {
  @override
  final ProductRepository repository = MockProductRepository();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
class MockViewProductUsecase implements ViewProductUsecase {
  @override
  final ProductRepository repository = MockProductRepository();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}