import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imagePath,
    required super.category,
    required super.price,
    required super.rating,
  });

  // Factory constructor to create a ProductModel from a JSON map
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

  // Method to convert a ProductModel instance to a JSON map
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