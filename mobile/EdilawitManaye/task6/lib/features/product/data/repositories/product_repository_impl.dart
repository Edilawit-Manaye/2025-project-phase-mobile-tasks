import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

// This class implements the contract from the domain layer.
class ProductRepositoryImpl implements ProductRepository {
  // This list acts as our in-memory "database".
  // Using a Singleton pattern to ensure all pages use the same instance.
  ProductRepositoryImpl._();
  static final ProductRepositoryImpl instance = ProductRepositoryImpl._();

  final List<ProductEntity> _products = [
    ProductEntity(id: 1, imagePath: 'images/bestShoes.jpg', title: 'Derby Leather Shoes', category: 'Men\'s shoe', price: 120, rating: 4.0, description: "A derby leather shoe is a classic..."),
    ProductEntity(id: 2, imagePath: 'images/bestShoes.jpg', title: 'Classic Ankle Boots', category: 'Women\'s shoe', price: 150, rating: 4.5, description: "Elegant and stylish ankle boots..."),
  ];

  @override
  Future<List<ProductEntity>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_products);
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products.firstWhere((p) => p.id == id);
  }

  @override
  Future<void> createProduct(ProductEntity product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products.add(product.copyWith(id: DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products.removeWhere((p) => p.id == id);
  }
}