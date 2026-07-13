// import 'package:equatable/equatable.dart';
//
// // This file is now clean. It only defines the ProductEntity.
// // It has NO imports from the data layer and NO lists.
// class ProductEntity extends Equatable {
//   final int id;
//   final String title;
//   final String description;
//   final String imagePath;
//   final String category;
//   final double price;
//   final double rating;
//
//   const ProductEntity({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     required this.category,
//     required this.price,
//     required this.rating,
//   });
//
//   ProductEntity copyWith({
//     int? id, String? title, String? description, String? imagePath,
//     String? category, double? price, double? rating,
//   }) {
//     return ProductEntity(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       imagePath: imagePath ?? this.imagePath,
//       category: category ?? this.category,
//       price: price ?? this.price,
//       rating: rating ?? this.rating,
//     );
//   }
//
//   @override
//   List<Object?> get props => [id, title, description, imagePath, category, price, rating];
// }




import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id; // The API uses a string ID (like "689343e8c293c0e593bf69b7")
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  // These fields are optional as they may not be in the API response
  final String? category;
  final double? rating;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.category,
    this.rating,
  });

  // The 'copyWith' method is included here for easy, immutable updates.
  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    String? category,
    double? rating,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }

  // This is required by Equatable for value-based comparison.
  @override
  List<Object?> get props => [id, name, description, imageUrl, price, category, rating];
}