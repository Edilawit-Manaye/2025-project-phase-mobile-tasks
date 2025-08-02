import '../models/product_model.dart';
import '../../domain/entities/product_entity.dart';

// This class's only job is to convert between the Model and the Entity.
class ProductMapper {
  // Converts a Data-layer Model into a Domain-layer Entity
  static ProductEntity toEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      imagePath: model.imagePath,
      category: model.category,
      price: model.price,
      rating: model.rating,
    );
  }

  // Converts a Domain-layer Entity into a Data-layer Model
  static ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imagePath: entity.imagePath,
      category: entity.category,
      price: entity.price,
      rating: entity.rating,
    );
  }
}