import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

// The base class for all events
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

// Event to load all products
class LoadAllProductEvent extends ProductEvent {}

// Event to get a single product by its ID
class GetSingleProductEvent extends ProductEvent {
  final int id;
  const GetSingleProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// Event to create a new product
class CreateProductEvent extends ProductEvent {
  final ProductEntity product;
  const CreateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// Event to update an existing product
class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;
  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// Event to delete a product by its ID
class DeleteProductEvent extends ProductEvent {
  final int id;
  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}