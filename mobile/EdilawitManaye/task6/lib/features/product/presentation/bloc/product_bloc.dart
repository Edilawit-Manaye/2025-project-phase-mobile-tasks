import 'package:bloc/bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/view_all_products_usecase.dart';
import '../../domain/usecases/view_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase viewAllProducts;
  final ViewProductUsecase viewProduct;
  final CreateProductUsecase createProduct;
  final UpdateProductUsecase updateProduct;
  final DeleteProductUsecase deleteProduct;

  ProductBloc({
    required this.viewAllProducts,
    required this.viewProduct,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(InitialState()) { // Set up the initial state
    // Define how to handle each event
    on<LoadAllProductEvent>(_onLoadAllProducts);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<GetSingleProductEvent>(_onGetSingleProduct);
  }

  // Event handler for loading all products
  Future<void> _onLoadAllProducts(LoadAllProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final (failure, products) = await viewAllProducts(NoParams());
    if (failure != null) {
      emit(const ErrorState('Failed to fetch products.'));
    } else {
      emit(LoadedAllProductState(products ?? []));
    }
  }

  // Event handler for creating a product
  Future<void> _onCreateProduct(CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final (failure, _) = await createProduct(event.product);
    if (failure != null) {
      emit(const ErrorState('Failed to create product.'));
    } else {
      emit(const OperationSuccessState('Product created successfully!'));
    }
  }

  // Event handler for updating a product
  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final (failure, _) = await updateProduct(event.product);
    if (failure != null) {
      emit(const ErrorState('Failed to update product.'));
    } else {
      emit(const OperationSuccessState('Product updated successfully!'));
    }
  }

  // Event handler for deleting a product
  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final (failure, _) = await deleteProduct(DeleteProductParams(event.id));
    if (failure != null) {
      emit(const ErrorState('Failed to delete product.'));
    } else {
      emit(const OperationSuccessState('Product deleted successfully!'));
    }
  }

  // Event handler for getting a single product
  Future<void> _onGetSingleProduct(GetSingleProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final (failure, product) = await viewProduct(ViewProductParams(event.id));
    if (failure != null || product == null) {
      emit(const ErrorState('Failed to fetch product details.'));
    } else {
      emit(LoadedSingleProductState(product));
    }
  }
}