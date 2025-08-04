import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class DetailPage extends StatelessWidget {
  final ProductEntity product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Note: The size selector is now stateless. For it to change color,
    // this would need to be a StatefulWidget or use a more localized state management.
    // For this task, we focus on the main BLoC integration.
    final sizes = [39, 40, 41, 42, 43, 44];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(product.imagePath, width: double.infinity, height: 350, fit: BoxFit.cover),
                Positioned(
                  top: 40, left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.category, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 5),
                          Text("(${product.rating})", style: const TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                      Text("\$${product.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: sizes.map((size) {
                      bool isSelected = size == 41; // Placeholder
                      return Container(
                        width: 50, height: 50, alignment: Alignment.center,
                        decoration: BoxDecoration(color: isSelected ? const Color(0xFF4A4EFE) : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                        child: Text(size.toString(), style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(product.description, style: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Dispatch the delete event to the BLoC
                  context.read<ProductBloc>().add(DeleteProductEvent(product.id));
                  Navigator.pop(context); // Go back to the home page
                },
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-update', arguments: product);
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: const Color(0xFF4A4EFE), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("UPDATE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}