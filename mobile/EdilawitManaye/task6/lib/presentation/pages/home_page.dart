import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/view_all_products_usecase.dart';

// --- THIS IS THE CORRECTED, SHARED "SINGLETON" FAKE REPOSITORY ---
class FakeProductRepository implements ProductRepository {
  // 1. Create a private constructor
  FakeProductRepository._();

  // 2. Create a single, static, final instance of this class
  static final FakeProductRepository instance = FakeProductRepository._();

  // 3. The "database" list now belongs to this single instance
  final List<Product> _products = [
    Product(id: 1, imagePath: 'images/bestShoes.jpg', title: 'Derby Leather Shoes', category: 'Men\'s shoe', price: 120, rating: 4.0, description: "A derby leather shoe is a classic and versatile footwear option..."),
    Product(id: 2, imagePath: 'images/bestShoes.jpg', title: 'Classic Ankle Boots', category: 'Women\'s shoe', price: 150, rating: 4.5, description: "Elegant and stylish ankle boots perfect for any occasion..."),
  ];

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_products);
  }

  @override
  Future<Product> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products.firstWhere((p) => p.id == id);
  }

  @override
  Future<void> createProduct(Product product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _products.add(product.copyWith(id: DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Future<void> updateProduct(Product product) async {
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ViewAllProductsUsecase viewAllProductsUsecase;
  late Future<List<Product>> _productsFuture;

  // Use the single, shared instance of the repository
  final ProductRepository repository = FakeProductRepository.instance;

  @override
  void initState() {
    super.initState();
    viewAllProductsUsecase = ViewAllProductsUsecase(repository);
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productsFuture = viewAllProductsUsecase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) return _buildHeader();
                if (index == 1) return _buildTitleBar();
                final product = products[index - 2];
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(context, '/detail', arguments: product);
                      _loadProducts(); // Refresh the list when returning
                    },
                    child: ProductCard(product: product),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add-update');
          _loadProducts();
        },
        backgroundColor: const Color(0xFF4A4EFE),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12))),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('July 14, 2023', style: TextStyle(color: Colors.grey, fontSize: 12)),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(text: 'Hello, '),
                    TextSpan(text: 'Yohannes', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
            child: IconButton(icon: const Icon(Icons.notifications_none_outlined, color: Colors.black54), onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Available Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(12)),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: Image.asset(product.imagePath, fit: BoxFit.cover, width: double.infinity, height: 180),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.category, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text('(${product.rating})', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}