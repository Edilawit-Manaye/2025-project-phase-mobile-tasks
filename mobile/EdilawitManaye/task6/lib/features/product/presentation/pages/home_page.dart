import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/view_all_products_usecase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get the use case directly from the service locator.
  final viewAllProductsUsecase = sl<ViewAllProductsUsecase>();
  late Future<(Failure?, List<ProductEntity>)> _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // This method can be called to refresh the list of products.
  void _loadProducts() {
    setState(() {
      _productsFuture = viewAllProductsUsecase(NoParams());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: FutureBuilder<(Failure?, List<ProductEntity>)>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.$1 != null) {
              final failure = snapshot.data?.$1;
              return Center(child: Text('Error: ${snapshot.error ?? failure}'));
            }

            final products = snapshot.data!.$2;
            if (products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

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
                      _loadProducts(); // Refresh the list when returning from the detail page
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
          _loadProducts(); // Refresh the list after potentially adding a new product
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
          Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12))),
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
  final ProductEntity product;
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