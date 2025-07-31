class Product {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final String category;
  final double price;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.rating,
  });

  // Helper method for updating
  Product copyWith({
    int? id, String? title, String? description, String? imagePath,
    String? category, double? price, double? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }
}