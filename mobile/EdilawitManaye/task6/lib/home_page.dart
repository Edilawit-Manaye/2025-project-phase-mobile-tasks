

import 'package:flutter/material.dart';
import 'package:task6/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // A sample list of products. In a real app, this would come from a database.
  final List<Product> _products = [
    Product(
        id: 1,
        imagePath: 'images/bestShoes.jpg',
        title: 'Derby Leather Shoes',
        category: 'Men\'s shoe',
        price: 120,
        rating: 4.0,
        description: "A derby leather shoe is a classic..."),
    Product(
        id: 2,
        imagePath: 'images/bestShoes.jpg',
        title: 'Classic Ankle Boots',
        category: 'Women\'s shoe',
        price: 150,
        rating: 4.5,
        description: "Elegant and stylish ankle boots..."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          itemCount: _products.length + 2, // item count for header and list
          itemBuilder: (context, index) {
            if (index == 0) return _buildHeader();
            if (index == 1) return _buildTitleBar();

            final productIndex = index - 2;
            final product = _products[productIndex];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to detail page with product data
                  Navigator.pushNamed(context, '/detail', arguments: product);
                },
                child: ProductCard(product: product),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to add page and wait for a result
          final result = await Navigator.pushNamed(context, '/add-update');
          if (result != null && result is Product) {
            setState(() {
              _products.add(result);
            });
          }
        },
        backgroundColor: const Color(0xFF4A4EFE),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
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
              // Navigate to the Search Page
              Navigator.pushNamed(context, '/search');
            },
          ),
        ),
      ],
    );
  }
}

// Reusable ProductCard - now takes a Product object
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
