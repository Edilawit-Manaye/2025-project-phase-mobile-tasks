import 'package:equatable/equatable.dart';

// This file is now clean. It only defines the ProductEntity.
// It has NO imports from the data layer and NO lists.
class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final String category;
  final double price;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.rating,
  });

  ProductEntity copyWith({
    int? id, String? title, String? description, String? imagePath,
    String? category, double? price, double? rating,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [id, title, description, imagePath, category, price, rating];
}