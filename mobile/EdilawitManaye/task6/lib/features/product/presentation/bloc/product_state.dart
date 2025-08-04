import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

// The base class for all states
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// The initial state before anything has happened
class InitialState extends ProductState {}

// The state when data is being fetched
class LoadingState extends ProductState {}

// The state when all products have been successfully loaded
class LoadedAllProductState extends ProductState {
  final List<ProductEntity> products;
  const LoadedAllProductState(this.products);

  @override
  List<Object?> get props => [products];
}

// The state when a single product has been successfully loaded
class LoadedSingleProductState extends ProductState {
  final ProductEntity product;
  const LoadedSingleProductState(this.product);

  @override
  List<Object?> get props => [product];
}

// The state when an operation has completed successfully (like create, update, delete)
// We add this for better UI feedback
class OperationSuccessState extends ProductState {
  final String message;
  const OperationSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

// The state when an error has occurred
class ErrorState extends ProductState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}