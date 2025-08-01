import 'package:equatable/equatable.dart';

// The class now extends Equatable to enable value-based comparison.
class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final String category;
  final double price;
  final double rating;

  // The constructor is now 'const' for better performance.
  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.rating,
  });

  // The copyWith method is correctly included for easy updates.
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

  // This is the required override from Equatable to fix the test.
  // It tells Dart which properties to use for comparison.
  @override
  List<Object?> get props => [id, title, description, imagePath, category, price, rating];
}