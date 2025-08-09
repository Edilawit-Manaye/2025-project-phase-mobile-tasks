// import '../../domain/entities/product_entity.dart';
//
// class ProductModel extends ProductEntity {
//   const ProductModel({
//     required super.id,
//     required super.title,
//     required super.description,
//     required super.imagePath,
//     required super.category,
//     required super.price,
//     required super.rating,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       imagePath: json['imagePath'],
//       category: json['category'],
//       price: (json['price'] as num).toDouble(),
//       rating: (json['rating'] as num).toDouble(),
//     );
//   }
//
//   factory ProductModel.fromEntity(ProductEntity entity) {
//     return ProductModel(
//       id: entity.id,
//       title: entity.title,
//       description: entity.description,
//       imagePath: entity.imagePath,
//       category: entity.category,
//       price: entity.price,
//       rating: entity.rating,
//     );
//   }
//
//   // THIS IS THE CORRECTED METHOD
//   // It now has an optional parameter to exclude the 'id' field, which is
//   // necessary for the 'create' API endpoint.
//   Map<String, dynamic> toJson({bool excludeId = false}) {
//     final Map<String, dynamic> jsonMap = {
//       'title': title,
//       'description': description,
//       'imagePath': imagePath,
//       'category': category,
//       'price': price,
//       'rating': rating,
//     };
//
//     // Only add the 'id' to the map if we are NOT excluding it.
//     if (!excludeId) {
//       jsonMap['id'] = id;
//     }
//
//     return jsonMap;
//   }
// }





import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
    super.category,
    super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      // THIS IS THE FIX:
      // The API sends the id as a String, so we just pass it along.
      // If it were a number, we would use .toString()
      id: json['id'] as String,
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      category: entity.category,
      price: entity.price,
      rating: entity.rating,
    );
      }

  Map<String, dynamic> toJson({bool excludeId = false}) {
    final Map<String, dynamic> jsonMap = {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      if (category != null) 'category': category,
      if (rating != null) 'rating': rating,
    };

    if (!excludeId) {
      jsonMap['id'] = id;
    }

    return jsonMap;
  }
}