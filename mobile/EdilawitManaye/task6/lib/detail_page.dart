
import 'package:flutter/material.dart';
import '../product_model.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedSize = 41;
  final sizes = [39, 40, 41, 42, 43, 44];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(widget.product.imagePath, width: double.infinity, height: 350, fit: BoxFit.cover),
                Positioned(
                  top: 40,
                  left: 15,
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
                      Text(widget.product.category, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 5),
                          Text('(${widget.product.rating})', style: const TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                      Text('\$${widget.product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Size:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: sizes.map((size) {
                      bool isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          width: 50, height: 50, alignment: Alignment.center,
                          decoration: BoxDecoration(color: isSelected ? const Color(0xFF4A4EFE) : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                          child: Text(size.toString(), style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(widget.product.description, style: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
      // ==========================================================
      // === THIS IS THE FULLY CORRECTED BOTTOM NAVIGATION BAR    ===
      // ==========================================================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                },
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                // This is the corrected solution
                onPressed: () async {
                  // Store the Navigator BEFORE the 'await'.
                  final navigator = Navigator.of(context);

                  // This is the 'async gap'. We use the stored navigator to push.
                  final updatedProduct = await navigator.pushNamed(
                    '/add-update',
                    arguments: widget.product,
                  );

                  // Now, check if the widget is still on screen AFTER the 'await'.
                  if (!context.mounted) return;

                  // We use the stored navigator again to pop.
                  if (updatedProduct != null && updatedProduct is Product) {
                    navigator.pop(updatedProduct);
                  }
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: const Color(0xFF4A4EFE), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('UPDATE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}