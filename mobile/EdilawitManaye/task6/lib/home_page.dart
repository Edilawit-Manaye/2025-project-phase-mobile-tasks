import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set a light gray background color like in the design
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            // Section 1: Header with user greeting and notification icon
            _buildHeader(),
            const SizedBox(height: 24),

            // Section 2: "Available Products" title and search icon
            _buildTitleBar(),
            const SizedBox(height: 16),

            // Section 3: The list of product cards
            const ProductCard(
              // IMPORTANT: Corrected image path
              imagePath: 'images/bestShoes.jpg',
              title: 'Derby Leather Shoes',
              category: 'Men\'s shoe',
              price: 120,
              rating: 4.0,
            ),
            const SizedBox(height: 16),
            const ProductCard(
              imagePath: 'images/bestShoes.jpg',
              title: 'Derby Leather Shoes',
              category: 'Men\'s shoe',
              price: 120,
              rating: 4.0,
            ),
            const SizedBox(height: 16),
            const ProductCard(
              imagePath: 'images/bestShoes.jpg',
              title: 'Derby Leather Shoes',
              category: 'Men\'s shoe',
              price: 120,
              rating: 4.0,
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add new product action
        },
        backgroundColor: const Color(0xFF4A4EFE), // Custom blue color from design
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  // Helper widget for the top header section
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 12),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July 14, 2023',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            RichText(
              text: TextSpan(
                // This is the default style for all text spans.
                // Children can override this.
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,

                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Hello, '),

                   TextSpan(
                    text: 'Yohannes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        const Spacer(), // Pushes the icon to the far right
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black54),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ),
      ],
    );
  }

  // Helper widget for the "Available Products" title bar
  Widget _buildTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Available Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,

            fontSize: 22,
            color: Colors.black,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {
              // Handle search tap
            },
          ),
        ),
      ],
    );
  }
}


// A reusable widget for displaying a single product card
class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String category;
  final double price;
  final double rating;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
  });

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
          // Product Image with rounded corners at the top
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180, // Fixed height for the image
            ),
          ),
          // Product details section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      '\$$price',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '($rating)',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
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