import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imagePath,
    required super.category,
    required super.price,
    required super.rating,
  });

  // A factory constructor to create a ProductModel from a JSON map (for data coming from an API)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
    );
  }

  // A factory constructor to create a ProductModel from a ProductEntity (for data going to the data layer)
  factory ProductModel.fromEntity(ProductEntity entity) {
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

  // Method to convert a ProductModel instance to a JSON map (for sending data to an API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'category': category,
      'price': price,
      'rating': rating,
    };
  }
}