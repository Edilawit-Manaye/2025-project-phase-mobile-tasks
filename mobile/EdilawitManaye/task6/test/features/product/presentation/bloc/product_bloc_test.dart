import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Use package imports to access your project files from the 'test' directory
import 'package:task6/core/error/failures.dart';
import 'package:task6/core/usecases/usecase.dart'; // <-- IMPORT THIS FOR NoParams
import 'package:task6/features/product/domain/entities/product_entity.dart';
import 'package:task6/features/product/presentation/bloc/product_bloc.dart';
import 'package:task6/features/product/presentation/bloc/product_event.dart';
import 'package:task6/features/product/presentation/bloc/product_state.dart';

// Import the manual mock file using a relative path
import 'mock_usecases.dart';

void main() {
  late ProductBloc productBloc;
  late MockViewAllProductsUsecase mockViewAllProductsUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockViewProductUsecase mockViewProductUsecase;

  setUp(() {
    mockViewAllProductsUsecase = MockViewAllProductsUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockViewProductUsecase = MockViewProductUsecase();

    productBloc = ProductBloc(
      viewAllProducts: mockViewAllProductsUsecase,
      createProduct: mockCreateProductUsecase,
      updateProduct: mockUpdateProductUsecase,
      deleteProduct: mockDeleteProductUsecase,
      viewProduct: mockViewProductUsecase,
    );
  });

  const tProduct = ProductEntity(id: 1, title: 'Test', description: '', imagePath: '', category: '', price: 10, rating: 5);
  final tProductList = [tProduct];

  test('initial state should be InitialState', () {
    expect(productBloc.state, equals(InitialState()));
  });

  group('LoadAllProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductState] when data is gotten successfully',
      build: () {
        // Arrange: tell the mock use case what to return
        mockViewAllProductsUsecase.resultToReturn = (null, tProductList);
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => <ProductState>[
        LoadingState(),
        LoadedAllProductState(tProductList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when getting data fails',
      build: () {
        // Arrange: tell the mock use case to return a failure
        // We now explicitly type the list to avoid the dynamic error
        mockViewAllProductsUsecase.resultToReturn = (ServerFailure(), <ProductEntity>[]);
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => <ProductState>[
        LoadingState(),
        const ErrorState('Failed to fetch products.'),
      ],
    );
  });
}