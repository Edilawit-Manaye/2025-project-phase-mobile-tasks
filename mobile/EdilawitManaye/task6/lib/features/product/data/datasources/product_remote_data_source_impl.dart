import '../models/product_model.dart';
import 'product_remote_data_source.dart';
import '../../domain/entities/product_entity.dart';
import '../mappers/product_mapper.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  // --- SINGLETON PATTERN ---
  // A private constructor prevents direct instantiation from other files.
  ProductRemoteDataSourceImpl._();
  // The single, static, final instance of this class.
  static final ProductRemoteDataSourceImpl instance = ProductRemoteDataSourceImpl._();
  // --- END SINGLETON PATTERN ---

  // This list acts as our shared in-memory "database".
  final List<ProductModel> _products = [
    ProductModel(id: 1, imagePath: 'images/bestShoes.jpg', title: 'Derby Leather Shoes', category: 'Men\'s shoe', price: 120, rating: 4.0, description: "A derby leather shoe is a classic..."),
    ProductModel(id: 2, imagePath: 'images/bestShoes.jpg', title: 'Classic Ankle Boots', category: 'Women\'s shoe', price: 150, rating: 4.5, description: "Elegant and stylish ankle boots..."),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_products);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products.firstWhere((p) => p.id == id);
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final entity = ProductMapper.toEntity(product);
    final newEntity = entity.copyWith(id: DateTime.now().millisecondsSinceEpoch);
    _products.add(ProductMapper.fromEntity(newEntity));
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
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